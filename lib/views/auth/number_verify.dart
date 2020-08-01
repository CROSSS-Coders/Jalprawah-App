import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../components/auth/index.dart';
import '../../services/index.dart';
import './otp_verify.dart';
import '../../utils/constants.dart';

class NumberVerifyScreen extends StatefulWidget {
  @override
  _NumberVerifyScreenState createState() => _NumberVerifyScreenState();
}

class _NumberVerifyScreenState extends State<NumberVerifyScreen> {
  final GlobalKey<FormState> _phoneVerifyForm = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = new TextEditingController();
  AuthService authService = new AuthService();

  void _validateNumber() async {
    print('Hitting button');
    if (_phoneVerifyForm.currentState.validate()) {
      print('Sending request');
      bool success =
          await authService.otpRequest(_phoneNumberController.text.trim());
      if (success) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OTPVerifyScreen(
              phoneNumber: _phoneNumberController.text.trim(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kBlue, kDarkBlue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).devicePixelRatio * 50,
                      height: MediaQuery.of(context).devicePixelRatio * 85,
                      child: Container(
                        child: Image.asset(
                          'assets/logo_small_white.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _phoneVerifyForm,
                autovalidate: false,
                child: GFCard(
                  title: GFListTile(
                    title: Text(
                      'Welcome',
                      style: TextStyle(fontSize: kCardTitleSize),
                    ),
                  ),
                  content: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'India',
                                style: TextStyle(fontSize: kCardContentSize),
                              ),
                              Image.asset(
                                'assets/india.png',
                                scale: 1.8,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: kBlue,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '+91',
                              style: TextStyle(
                                fontSize: kCardContentSize,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  PhoneField(
                                    phoneNumberController:
                                        _phoneNumberController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RawMaterialButton(
                            onPressed: _validateNumber,
                            elevation: 2.0,
                            fillColor: kBlue,
                            child: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
