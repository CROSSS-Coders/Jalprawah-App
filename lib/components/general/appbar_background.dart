import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class BackgroundGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            kBlue,
            kDarkBlue,
          ],
        ),
      ),
    );
  }
}
