import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/widget/social_button.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/services/provider/authentication.dart';
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
        toolbarHeight: 50,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/nche_icon.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(height: screensize.height * 0.03),
                      Text(
                        'Hi There! 👋',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screensize.height * 0.02),
                      Text(
                        'Welcome, Sign Up To Continue',
                        style: style.copyWith(color: AppColor.darkerGrey),
                      ),
                    ],
                  ),

                  //
                  SizedBox(height: screensize.height * 0.04),
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
                      // SizedBox(height: screensize.height * 0.01),
                      // MyTextForm(
                      //   controller: _confirmPasswordField,
                      //   obscureText: _isObscureConfirmPassword,
                      //   hintText: 'Confirm password',
                      //   suffixIcon: IconButton(
                      //     icon: Icon(
                      //       _isObscureConfirmPassword
                      //           ? Icons.visibility
                      //           : Icons.visibility_off,
                      //       color: AppColor.grey,
                      //     ),
                      //     onPressed: () {
                      //       setState(
                      //         () {
                      //           _isObscureConfirmPassword =
                      //               !_isObscureConfirmPassword;
                      //         },
                      //       );
                      //     },
                      //   ),
                      //   validatior: (value) {
                      //     if (_passwordField.text !=
                      //         _confirmPasswordField.text) {
                      //       return 'The passwords do not match, pls verify*';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: AppColor.white,
                            activeColor: AppColor.darkerYellow,
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
                  SizedBox(height: screensize.height * 0.02),
                  MainButton(
                    backgroundColor:
                        ischecked ? AppColor.primaryColor : AppColor.lightGrey,
                    borderColor: Colors.transparent,
                    child: provider.isSignUp
                        ? buttonCircularIndicator
                        : Text(
                            'SIGN UP',
                            style: style.copyWith(
                              fontSize: 14,
                              color: ischecked
                                  ? AppColor.black
                                  : AppColor.darkerGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                  SizedBox(height: screensize.height * 0.03),
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
                        vertical: screensize.height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async =>
                              await provider.signInWithGoogle(context: context),
                          child: SocialButton(
                            assetUrl: 'assets/google_icon.png',
                            title: Text(
                              'Google',
                              style: style.copyWith(fontSize: 14),
                            ),
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
                          child: SocialButton(
                            assetUrl: 'assets/call_add.png',
                            title: Text(
                              'Phone no.',
                              style: style.copyWith(fontSize: 14),
                            ),
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
