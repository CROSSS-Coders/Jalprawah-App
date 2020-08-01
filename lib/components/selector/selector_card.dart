import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/dam.dart';
import '../general/index.dart';
import './chart_button.dart';
import './notification_button.dart';
import '../../utils/constants.dart';

class SelectorCard extends StatefulWidget {
  final DamInfo damData;
  final Function(int, bool) addChartCallback;
  final Function(int, bool) addNotificationCallback;
  final bool chartValue;
  final bool notificationValue;

  SelectorCard({
    this.damData,
    this.addChartCallback,
    this.addNotificationCallback,
    this.chartValue,
    this.notificationValue,
  });

  @override
  _SelectorCardState createState() => _SelectorCardState(
      chartValue: this.chartValue, notificationValue: notificationValue);
}

class _SelectorCardState extends State<SelectorCard> {
  bool chartValue;
  bool notificationValue;

  _SelectorCardState({this.chartValue, this.notificationValue});

  @override
  Widget build(BuildContext context) {
    return GFCard(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      color: kDarkBlue,
      title: GFListTile(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Flexible(
                child: Text(
                  widget.damData.getDamName,
                  style: TextStyle(
                    fontSize: kCardTitleSize,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          chartValue = !chartValue;
                          widget.addChartCallback(
                            widget.damData.getDamID,
                            chartValue,
                          );
                        });
                      },
                      child: ChartButton(selectedDamValue: chartValue),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          notificationValue = !notificationValue;
                          widget.addNotificationCallback(
                            widget.damData.getDamID,
                            notificationValue,
                          );
                        });
                      },
                      child: NotificationButton(
                        selectedDamValue: notificationValue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      content: DisplayMetadata(
        damData: widget.damData,
      ),
    );
  }
}
