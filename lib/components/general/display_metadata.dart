import 'package:flutter/material.dart';

import '../../models/dam.dart';
import '../../utils/constants.dart';

class DisplayMetadata extends StatelessWidget {
  final DamInfo damData;

  DisplayMetadata({this.damData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Status',
              style: TextStyle(
                fontSize: kCardContentSize,
                color: kWhite,
              ),
            ),
            Text(
              damData.getRiverName,
              style: TextStyle(
                fontSize: kCardContentSize,
                color: kWhite,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              damData.getDOE != null ? damData.getDOE : 'No Data',
              style: TextStyle(
                color: kWhite,
              ),
            ),
            Text(
              damData.getDistrict != null ? damData.getDistrict : 'No Data',
              style: TextStyle(
                color: kWhite,
              ),
            ),
            Text(
              damData.getStationCode != null
                  ? damData.getStationCode
                  : 'No Data',
              style: TextStyle(
                color: kWhite,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
