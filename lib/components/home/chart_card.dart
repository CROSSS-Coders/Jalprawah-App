import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../general/index.dart';
import '../../services/index.dart';
import './work_around.dart';
import '../../models/dam_values.dart';
import '../../models/dam.dart';
import '../../utils/constants.dart';

class ChartCard extends StatefulWidget {
  final ValueKey key;
  final Function(ChartCard) removeDamCallback;
  final DamInfo damData;
  final bool showButton;

  ChartCard({
    this.key,
    this.damData,
    this.removeDamCallback,
    this.showButton: true,
  });

  int get getDamID => damData.getDamID;

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  List<charts.Series<ValueTime, DateTime>> _chartData;
  DamValueService damValueService = new DamValueService();

  @override
  void dispose() {
    print('Disposing: ' + widget.getDamID.toString());
    super.dispose();
  }

  void initChart(damValues) {
    List<ValueTime> forecastData = damValues.getForecastValues;
    List<ValueTime> waterData = damValues.getWaterValues;

    var temp = [
      charts.Series<ValueTime, DateTime>(
        id: 'Current',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ValueTime point, _) => point.getTime,
        measureFn: (ValueTime point, _) => point.getValues,
        data: waterData,
      ),
      charts.Series<ValueTime, DateTime>(
        id: 'Forecast',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (ValueTime point, _) => point.getTime,
        measureFn: (ValueTime point, _) => point.getValues,
        data: forecastData,
      ),
    ];

    setState(() {
      _chartData = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.damData.getDamID);
    damValueService.fetchDamInfo(widget.damData.getDamID).then(
          (value) => initChart(value),
        );
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
                    widget.damData.getDamName,
                    style: TextStyle(fontSize: kCardTitleSize, color: kWhite),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Status: Normal',
                    style: TextStyle(fontSize: kCardContentSize, color: kWhite),
                  ),
                ],
              ),
            ),
            widget.showButton
                ? ButtonTheme(
                    minWidth: 0,
                    height: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: Icon(
                        Icons.close,
                        color: kGrey,
                      ),
                      onPressed: () {
                        widget.removeDamCallback(widget);
                      },
                    ),
                  )
                : Container(),
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
                      charts.PanAndZoomBehavior(),
                      charts.SeriesLegend(
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.white),
                      ),
                    ],
                    animate: true,
                    primaryMeasureAxis: charts.NumericAxisSpec(
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
                          charts.BasicNumericTickProviderSpec(zeroBound: false),
                    ),
                    domainAxis: DateTimeAxisSpecWorkaround(
                      viewport: charts.DateTimeExtents(
                        start: DateTime.now().subtract(
                          Duration(days: 3),
                        ),
                        end: DateTime.now().add(
                          Duration(days: 3),
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
