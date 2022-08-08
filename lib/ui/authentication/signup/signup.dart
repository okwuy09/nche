import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/mytextform.dart';
import 'package:nche/components/social_button.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider.dart';
import 'package:nche/ui/authentication/phoneSignin/phone_login.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _fullNameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool ischecked = false;

  // This function is triggered when the floating button is pressed check if the device is connected to internet.
  // testing
  // bool? _isConnected;
  // Future<void> _checkInternetConnection() async {
  //   try {
  //     final response = await InternetAddress.lookup('www.kindacode.com');
  //     if (response.isNotEmpty) {
  //       setState(() {
  //         _isConnected = true;
  //       });
  //     }
  //   } on SocketException catch (err) {
  //     setState(() {
  //       _isConnected = false;
  //     });
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //   }
  // }
  //

  @override
  void dispose() {
    _fullNameField.dispose();
    _userName.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    _confirmPasswordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColor.white,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        elevation: 0,
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
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //
                  //SizedBox(height: screensize.height * 0.02),
                  Column(
                    children: [
                      Image.asset(
                        'assets/nche_logo.png',
                        width: 122,
                        height: 50,
                      ),
                      Text(
                        'Welcome, Sign Up',
                        style: style.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  //
                  SizedBox(height: screensize.height * 0.02),
                  Column(
                    children: <Widget>[
                      //
                      MyTextForm(
                        controller: _fullNameField,
                        obscureText: false,
                        hintText: 'Full name',
                        autofillHints: const [AutofillHints.name],
                        validatior: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter fullname*';
                          }
                          return null;
                        },
                      ),

                      //
                      SizedBox(height: screensize.height * 0.01),
                      MyTextForm(
                        controller: _userName,
                        obscureText: false,
                        hintText: 'Username',
                        // autofillHints: const [AutofillHints.givenName],
                        validatior: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Username*';
                          }
                          return null;
                        },
                      ),

                      //
                      SizedBox(height: screensize.height * 0.01),
                      MyTextForm(
                        controller: _emailField,
                        obscureText: false,
                        hintText: 'Email',
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        validatior: (input) => !(input!.isNotEmpty &&
                                input.contains('@') &&
                                input.contains('.com'))
                            ? "You have entered a wrong email format"
                            : null,
                      ),

                      //
                      SizedBox(height: screensize.height * 0.01),
                      MyTextForm(
                        controller: _passwordField,
                        obscureText: _isObscurePassword,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscurePassword = !_isObscurePassword;
                              });
                            }),
                        validatior: (value) {
                          bool passValid = RegExp(
                                  "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*?[!@#\$&*~]).*")
                              .hasMatch(value!);
                          if (value.isEmpty || !passValid) {
                            return 'Please enter Valid Pasword*';
                          }
                          return null;
                        },
                      ),

                      //
                      SizedBox(height: screensize.height * 0.01),
                      MyTextForm(
                        controller: _confirmPasswordField,
                        obscureText: _isObscureConfirmPassword,
                        hintText: 'Confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.grey,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _isObscureConfirmPassword =
                                    !_isObscureConfirmPassword;
                              },
                            );
                          },
                        ),
                        validatior: (value) {
                          if (_passwordField.text !=
                              _confirmPasswordField.text) {
                            return 'The passwords do not match, pls verify*';
                          }
                          return null;
                        },
                      ),

                      //
                      Row(
                        children: [
                          Checkbox(
                            checkColor: AppColor.white,
                            activeColor: AppColor.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: ischecked,
                            onChanged: (value) {
                              setState(() {
                                ischecked = value!;
                              });
                            },
                          ),
                          //
                          Text(
                            'I agree with the terms and policies.',
                            style: style.copyWith(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),

                  //
                  SizedBox(height: screensize.height * 0.025),
                  MainButton(
                    backgroundColor:
                        ischecked ? AppColor.primaryColor : AppColor.lightGrey,
                    borderColor: Colors.transparent,
                    textColor: ischecked ? AppColor.black : AppColor.darkerGrey,
                    text: 'SIGN UP',
                    onTap: () async {
                      if (ischecked) {
                        if (_formkey.currentState!.validate()) {
                          setState(() {});

                          await provider.signUp(
                            email: _emailField.text,
                            fullName: _fullNameField.text,
                            password: _passwordField.text,
                            userName: _userName.text,
                            context: context,
                          );
                        }
                      }
                    },
                  ),

                  //
                  SizedBox(height: screensize.height * 0.02),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Or sign up using',
                          style: style.copyWith(fontSize: 13),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  //
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screensize.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async =>
                              await provider.signInWithGoogle(context: context),
                          child: const SocialButton(
                            assetUrl: 'assets/google_icon.png',
                            title: 'Google',
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PhoneLogin(),
                            ),
                          ),
                          child: const SocialButton(
                            assetUrl: 'assets/call_add.png',
                            title: 'Phone no.',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
