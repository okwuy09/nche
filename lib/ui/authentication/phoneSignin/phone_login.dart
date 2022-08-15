import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider/authentication.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nche/ui/authentication/phoneSignin/phone_otp.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: true);

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
                        'Verify it\'s you',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // text that display your email after sending password recovery
                      Text(
                        'We will send you a one time password to this number',
                        style: style.copyWith(color: AppColor.darkerGrey),
                      ),

                      SizedBox(height: screensize.height * 0.05),

                      //phone text field
                      IntlPhoneField(
                        style: style,
                        dropdownIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.black,
                        ),
                        cursorColor: AppColor.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.white,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: AppColor.red,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: AppColor.darkerGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: AppColor.grey,
                            ),
                          ),
                          hintText: 'Phone Number',
                        ),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          //print(phone.completeNumber);
                          setState(() {
                            phoneNumber = phone.completeNumber;
                          });
                        },
                      )
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.17),
                // button Confirm otp entered
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        borderColor: Colors.transparent,
                        child: Text(
                          'GENERATE OTP',
                          style: style.copyWith(
                            fontSize: 14,
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: AppColor.primaryColor,
                        onTap: () async {
                          if (_globalFormKey.currentState!.validate()) {
                            setState(() {});
                            await provider.signInWithPhoneNumber(
                                context: context, mobile: phoneNumber);
                          }
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
