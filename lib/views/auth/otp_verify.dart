import 'package:flutter/material.dart';
import 'package:sih_notifier/views/home/index.dart';

import '../../components/auth/index.dart';
import '../../services/index.dart';
import '../../utils/constants.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String phoneNumber;

  OTPVerifyScreen({@required this.phoneNumber});

  @override
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  AuthService authService = new AuthService();
  TextEditingController _otpController = new TextEditingController();
  bool showPopup = false;

  void _validateOTP() async {
    print('Sending request');
    var user = await authService.otpVerify(
        this.widget.phoneNumber, _otpController.text.trim());
    if (user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kBlue, kDarkBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: showPopup
            ? AlertDialog(
                title: Text('Oops! An Error has occurred!'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Please enter your OTP again, or generate a new one!'),
                    SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: kBlue),
                        ),
                        child: Text('Close'),
                        onPressed: () {
                          setState(
                            () {
                              showPopup = false;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      'One Time Password',
                      style: TextStyle(
                        fontSize: kCardTitleSize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  OTPFields(
                    otpController: _otpController,
                  ),
                  Center(
                    child: RawMaterialButton(
                      onPressed: _validateOTP,
                      elevation: 5.0,
                      fillColor: kBlue,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Enter OTP sent to',
                          style: TextStyle(
                            fontSize: kCardContentSize * 0.85,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '+91 ${widget.phoneNumber}',
                          style: TextStyle(
                            fontSize: kCardContentSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
