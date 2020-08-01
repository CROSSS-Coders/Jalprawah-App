import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../utils/constants.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final int value;

  SummaryCard({
    this.title,
    this.icon,
    this.value,
  });

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
        margin: EdgeInsets.all(0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: kCardTitleSize,
                  color: kWhite,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 0.0,
              ),
              child: this.icon,
            )
          ],
        ),
      ),
      content: Text(
        this.value.toString(),
        style: TextStyle(
          fontSize: kCardContentSize,
          color: kWhite,
        ),
      ),
    );
  }
}
