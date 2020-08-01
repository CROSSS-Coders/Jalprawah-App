import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class BottomSaveSheet extends StatelessWidget {
  final VoidCallback saveSelectionCallback;

  BottomSaveSheet({this.saveSelectionCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: kBlue,
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: kCardContentSize,
          ),
        ),
        onPressed: saveSelectionCallback,
      ),
    );
  }
}
