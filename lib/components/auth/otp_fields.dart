import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPFields extends StatelessWidget {
  final TextEditingController otpController;

  OTPFields({@required this.otpController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PinCodeTextField(
        length: 4,
        obsecureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Colors.white,
          activeColor: Colors.transparent,
          inactiveColor: Colors.white,
          disabledColor: Colors.white,
          selectedColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: otpController,
        onCompleted: (value) {
          print(value);
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
