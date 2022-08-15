import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/mytextform.dart';
import 'package:nche/components/social_button.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider/authentication.dart';
import 'package:nche/ui/authentication/onboarding/onboardingscreen.dart';
import 'package:nche/ui/authentication/phoneSignin/phone_login.dart';
import 'package:nche/ui/authentication/signin/forgot_password.dart';
import 'package:nche/ui/authentication/signup/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isObscurePassword = true;
  bool ischecked = false;

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
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
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', false);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const OnboardingPage(),
              ),
            );
          },
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
                        'Welcome Back, Sign In To Your Account',
                        style: style.copyWith(color: AppColor.darkerGrey),
                      ),
                    ],
                  ),

                  SizedBox(height: screensize.height * 0.04),
                  Column(
                    children: <Widget>[
                      // Email address field for login
                      MyTextForm(
                        controller: _emailField,
                        obscureText: false,
                        hintText: 'Email',
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        validatior: (input) => !(input!.isNotEmpty &&
                                input.contains('@') &&
                                input.contains('.com'))
                            ? "Please Enter Correct Email Address"
                            : null,
                      ),

                      // Password field for login
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
                            return 'Please Enter Valid Password*';
                          }
                          return null;
                        },
                      ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: style.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  //
                  SizedBox(height: screensize.height * 0.06),
                  MainButton(
                    backgroundColor: AppColor.primaryColor,
                    borderColor: Colors.transparent,
                    child: Text(
                      'SIGN IN',
                      style: style.copyWith(
                        fontSize: 14,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        await provider.signIn(
                          email: _emailField.text,
                          password: _passwordField.text,
                          context: context,
                        );
                      }
                    },
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have account?',
                        style: style.copyWith(
                            fontSize: 14, color: const Color(0xff4f4f4f)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUp(),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: style.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screensize.height * 0.06),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'OR',
                          style: style.copyWith(fontSize: 13),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  // aternative signIn
                  SizedBox(height: screensize.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                          onTap: () => Navigator.push(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
