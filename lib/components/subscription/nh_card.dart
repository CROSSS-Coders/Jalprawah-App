import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/dam.dart';
import '../general/index.dart';
import '../../utils/constants.dart';
import './delete_alert.dart';

class HandlerCard extends StatelessWidget {
  // TODO: Implement HandlerCard for notifications.

  final ValueKey key;
  final DamInfo damData;
  final Function(HandlerCard) removeDamCallback;

  int get getDamID => damData.getDamID;

  HandlerCard({
    this.key,
    this.damData,
    this.removeDamCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GFCard(
      color: kDarkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: GFListTile(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    damData.getDamName,
                    style: TextStyle(
                      fontSize: kCardTitleSize,
                      color: kWhite,
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: 0,
                  height: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: FlatButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                    child: Icon(
                      Icons.notifications_off,
                      color: kRed,
                    ),
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return DeleteAlert(
                            removeDamCallback: () {
                              removeDamCallback(this);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      content: DisplayMetadata(
        damData: damData,
      ),
    );
  }
}
