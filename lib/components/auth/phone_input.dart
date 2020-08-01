import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneNumberController;

  PhoneField({@required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: kCardContentSize),
      maxLength: 10,
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter Mobile Number',
      ),
      validator: (String phone) {
        String pattern = r'(^[0-9]{10}$)';
        RegExp regExp = RegExp(pattern);
        if (!regExp.hasMatch(phone)) {
          return 'Valid 10 Digit Phone is Required';
        }
        return null;
      },
    );
  }
}
