import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/progress_indicator.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider.dart';
import 'package:nche/ui/homepage/bottom_navbar.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OTPAuthentication extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OTPAuthentication({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  _OTPAuthenticationState createState() => _OTPAuthenticationState();
}

class _OTPAuthenticationState extends State<OTPAuthentication> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final OtpFieldController _otpSignInController = OtpFieldController();
  String? _smsCode;
  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start != 0) {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: true);
    final _phoneNumber = widget.phoneNumber.replaceRange(7, 11, "****");
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        title: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _globalFormKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify OTP',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // text that display your email after sending password recovery
                      SizedBox(height: screensize.height * 0.02),
                      Text(
                        'We send a code to ($_phoneNumber). Enter it here to verify your identity',
                        style: style.copyWith(color: AppColor.darkerGrey),
                      ),

                      //Otp text field
                      SizedBox(height: screensize.height * 0.05),
                      OTPTextField(
                        controller: _otpSignInController,
                        length: 6,
                        width: screensize.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 40,
                        otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: AppColor.primaryColor,
                          borderColor: Colors.transparent,
                          enabledBorderColor: Colors.transparent,
                          backgroundColor: AppColor.lightGrey,
                        ),
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 12,
                        style: style.copyWith(fontSize: 24),
                        onChanged: (pin) {
                          // print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          setState(() {
                            _smsCode = pin;
                          });
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Resend code after 60 seconds textbutton
                          // button is disabled within the 60 seconds

                          TextButton(
                            onPressed: _start == 0
                                ? () async =>
                                    await provider.signInWithPhoneNumber(
                                      context: context,
                                      mobile: widget.phoneNumber,
                                    )
                                : null,
                            child: Text(
                              'Resend Code',
                              style: style.copyWith(
                                color: _start == 0
                                    ? AppColor.darkerYellow
                                    : AppColor.grey,
                              ),
                            ),
                          ),

                          // Text widget to dispay the count down timer
                          Text(
                            _start.toString(),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),

                // button Confirm otp entered
                SizedBox(height: screensize.height * 0.15),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        borderColor: Colors.transparent,
                        text: 'VERIFY OTP',
                        backgroundColor: AppColor.primaryColor,
                        onTap: () async {
                          try {
                            MyIndicator().waiting(context);
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: widget.verificationId,
                                        smsCode: _smsCode!))
                                .then((value) async {
                              if (value.user != null) {
                                // Navigate to the home page if code confirmation is successful
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BottomNavBar(),
                                  ),
                                );
                              }
                            });
                          } catch (e) {
                            // pop out the loading screen with error occured
                            Navigator.pop(context);
                            handleFireBaseAlert(
                              context: context,
                              message: e.toString(),
                            );
                          }

                          //clear otp field on summit
                          _otpSignInController.clear();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
