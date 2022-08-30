import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/mytextform.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Center(
                child: Text(
                  'Change Password',
                  style: style.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            MyTextForm(
              controller: _currentPassword,
              obscureText: false,
              hintText: 'Current Password',
              validatior: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Current Password*';
                }
                return null;
              },
            ),
            //
            const SizedBox(height: 10),
            MyTextForm(
              controller: _newPassword,
              obscureText: false,
              hintText: 'New Password',
              validatior: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter New Password*';
                }
                return null;
              },
            ),
            //
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 30,
              ),
              child: MainButton(
                borderColor: Colors.transparent,
                child: provider.ischangePassword
                    ? buttonCircularIndicator
                    : Text(
                        'CHANGE PASSWORD',
                        style: style.copyWith(
                          fontSize: 14,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                backgroundColor: AppColor.primaryColor,
                onTap: () async {
                  await provider.changePassword(
                    _currentPassword.text,
                    _newPassword.text,
                    context,
                  );
                },
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
