import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DeleteAlert extends StatelessWidget {
  final VoidCallback removeDamCallback;

  DeleteAlert({this.removeDamCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text(
        'Are you sure?',
        style: TextStyle(fontSize: kCardTitleSize),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Please note, unsubscribing from the dam prevents you from receiving further notifications.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: kCardContentSize),
            ),
            Text(
              'Please select Confirm to unsubscribe.',
              style: TextStyle(fontSize: kCardContentSize),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  child: Text('Cancel'),
                  color: kBlue,
                  borderSide: BorderSide(color: kBlue, width: 2.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  color: kRed,
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    removeDamCallback();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
