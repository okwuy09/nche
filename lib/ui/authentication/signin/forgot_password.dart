import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/mytextform.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();

  @override
  void dispose() {
    _emailField.dispose();
    super.dispose();
  }

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
                        'Verify Email',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screensize.height * 0.02),
                      Text(
                        'Please Enter Your Registered Email Address Here To Reset Your Password',
                        style: style.copyWith(color: AppColor.darkerGrey),
                      ),
                      // text field
                      SizedBox(height: screensize.height * 0.05),
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
                    ],
                  ),
                ),

                // button Confirm otp entered
                SizedBox(height: screensize.height * 0.2),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        borderColor: Colors.transparent,
                        text: 'RESET PASSWORD',
                        backgroundColor: AppColor.primaryColor,
                        onTap: () async {
                          if (_globalFormKey.currentState!.validate()) {
                            setState(() {});
                            await provider.resetPassword(
                                email: _emailField.text, context: context);
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
