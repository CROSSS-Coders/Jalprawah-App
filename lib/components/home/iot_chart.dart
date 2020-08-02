import 'package:flutter/material.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:getwidget/getwidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../general/index.dart';
import '../../services/index.dart';
import './work_around.dart';
import '../../models/index.dart';
import '../../utils/constants.dart';

class IOTChart extends StatefulWidget {
  IOTChart();

  @override
  _IOTChartState createState() => _IOTChartState();
}

class _IOTChartState extends State<IOTChart> {
  List<charts.Series<ValueIOT, DateTime>> _chartData;
  IOTPusher iotPusher = new IOTPusher();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initChart() async {
    Channel channel = await iotPusher.initPusher();
    channel.bind('iot', (data) {
      print(data);
    });
    IOTValues iotValues = await iotPusher.fetchIOTInfo();
    List<ValueIOT> waterData = iotValues.getWaterValues;
    var initial = [
      charts.Series<ValueIOT, DateTime>(
        id: 'Current',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ValueIOT point, _) => point.getTime,
        measureFn: (ValueIOT point, _) => point.getValues,
        data: waterData,
      ),
    ];
    setState(() {
      _chartData = initial;
    });
  }

  @override
  void initState() {
    super.initState();
    initChart();
  }

  @override
  Widget build(BuildContext context) {
    return GFCard(
      color: kDarkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: GFListTile(
        margin: EdgeInsets.all(0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'IOT',
                    style: TextStyle(fontSize: kCardTitleSize, color: kWhite),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      content: _chartData != null
          ? Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200,
                  child: charts.TimeSeriesChart(
                    _chartData,
                    behaviors: [
                      charts.SlidingViewport(),
                      //charts.PanAndZoomBehavior(),
                      charts.SeriesLegend(
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.white),
                      ),
                    ],
                    animate: true,
                    primaryMeasureAxis: charts.NumericAxisSpec(
                      viewport: charts.NumericExtents(0, 25),
                      renderSpec: charts.GridlineRendererSpec(
                        // Tick and Label styling here.
                        labelStyle: charts.TextStyleSpec(
                            // size in Pts.
                            color: charts.MaterialPalette.white),
                        // Change the line colors to match text color.
                        lineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.white),
                      ),
                      tickProviderSpec:
                          charts.BasicNumericTickProviderSpec(zeroBound: true),
                    ),
                    domainAxis: DateTimeAxisSpecWorkaround(
                      tickProviderSpec:
                          charts.DayTickProviderSpec(increments: [2]),
                      viewport: charts.DateTimeExtents(
                        start: DateTime.now().subtract(
                          Duration(hours: 2),
                        ),
                        end: DateTime.now().add(
                          Duration(minutes: 1),
                        ),
                      ),
                      renderSpec: charts.SmallTickRendererSpec(
                        lineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.white),
                        // Tick and Label styling here.
                        labelStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : LoadingScreen(),
    );
  }
}
