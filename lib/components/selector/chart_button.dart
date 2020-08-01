import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ChartButton extends StatelessWidget {
  final bool selectedDamValue;

  ChartButton({this.selectedDamValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: selectedDamValue
            ? Icon(
                Icons.insert_chart,
                color: kBlue,
              )
            : Icon(
                Icons.add_circle_outline,
                color: kBlue,
              ),
      ),
    );
  }
}
