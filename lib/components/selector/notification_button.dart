import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class NotificationButton extends StatelessWidget {
  // TODO: Add functionality to NotificationButton
  final bool selectedDamValue;

  NotificationButton({this.selectedDamValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: selectedDamValue
            ? Icon(
                Icons.notifications,
                color: kGrey,
              )
            : Icon(
                Icons.notifications_none,
                color: kGrey,
              ),
      ),
    );
  }
}
