import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/mytextform.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  final Users userDetail;
  const UpdateProfile({Key? key, required this.userDetail}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  XFile? _profileImage;
  TextEditingController? _fullName;
  TextEditingController? _email;
  TextEditingController? _userName;
  TextEditingController? _countryState;
  TextEditingController? _phoneNo;
  TextEditingController? _userCity;

  @override
  void initState() {
    _fullName =
        TextEditingController(text: widget.userDetail.fullName ?? 'Full Name');
    _email = TextEditingController(text: widget.userDetail.email ?? 'Email');
    _userName =
        TextEditingController(text: widget.userDetail.userName ?? 'UserName');
    _countryState = TextEditingController(
        text: widget.userDetail.countryState ?? 'Your State');
    _phoneNo = TextEditingController(
        text: widget.userDetail.phoneNumber ?? 'Phone Number');
    _userCity =
        TextEditingController(text: widget.userDetail.userCity ?? 'Your City');
    super.initState();
  }

  // @override
  // void dispose() {
  //   _fullName.dispose();
  //   _email.dispose();
  //   _nigeriaState.dispose();
  //   _userName.dispose();
  //   _phoneNo.dispose();
  //   _nigeriaState.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenSize.height * 0.18,
                  child: Column(
                    children: [
                      Container(
                        height: screenSize.height * 0.14,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColor.darkerYellow,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(screenSize.width, 40.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              // Profile Appbar details
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Edit Profile',
                                    style: style.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(flex: 2, child: Container()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // profile infor

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // user full name
                  Text(
                    'Full Name',
                    style: style.copyWith(
                      fontSize: 12,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyTextForm(
                    controller: _fullName,
                    obscureText: false,
                  ),

                  // user  username field
                  SizedBox(height: screenSize.height * 0.03),
                  Text(
                    'UserName',
                    style: style.copyWith(
                      fontSize: 12,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyTextForm(
                    controller: _userName,
                    obscureText: false,
                  ),

                  // user Email Address
                  SizedBox(height: screenSize.height * 0.03),
                  Text(
                    'Email',
                    style: style.copyWith(
                      fontSize: 12,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyTextForm(
                    controller: _email,
                    obscureText: false,
                  ),

                  //

                  SizedBox(height: screenSize.height * 0.03),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User country state
                            Text(
                              'State',
                              style: style.copyWith(
                                fontSize: 12,
                                color: AppColor.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            MyTextForm(
                              controller: _countryState,
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),
                      // User current city
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City',
                              style: style.copyWith(
                                fontSize: 12,
                                color: AppColor.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            MyTextForm(
                              controller: _userCity,
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// user phone number
                  SizedBox(height: screenSize.height * 0.03),
                  Text(
                    'Phone No',
                    style: style.copyWith(
                      fontSize: 12,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyTextForm(
                    controller: _phoneNo,
                    obscureText: false,
                  ),

                  // update profile button

                  SizedBox(height: screenSize.height * 0.14),
                  MainButton(
                    borderColor: Colors.transparent,
                    child: provider.isUpdateProfile
                        ? buttonCircularIndicator
                        : Text('UPDATE',
                            style: style.copyWith(
                              fontSize: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                            )),
                    backgroundColor: AppColor.darkerYellow,
                    onTap: () async {
                      await provider.updateUserProfile(
                        context: context,
                        countryState: _countryState!.text,
                        email: _email!.text,
                        fullName: _fullName!.text,
                        phoneNumber: _phoneNo!.text,
                        userCity: _userCity!.text,
                        userName: _userName!.text,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
