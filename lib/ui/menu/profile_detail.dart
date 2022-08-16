import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/change_password_sheet.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/mytextform.dart';
import 'package:nche/components/popover.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/user_infor_tile.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/menu/update_profile.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  XFile? _profileImage;

  PersistentBottomSheetController? _bottomSheetController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            children: [
              SizedBox(
                height: screenSize.height * 0.29,
                child: Column(
                  children: [
                    Container(
                      height: screenSize.height * 0.2,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColor.darkerYellow,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(screenSize.width, 120.0),
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
                                  'Profile Detail',
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
              Positioned(
                left: screenSize.width / 2.7,
                bottom: screenSize.height * 0.04,
                child: Stack(
                  children: [
                    /// Usrs profile picture

                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColor.darkerYellow.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Positioned(
                          top: 3.5,
                          left: 3.5,
                          child: Container(
                            height: 93,
                            width: 93,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Image.network(
                                provider.userProfileImage,
                                //color: AppColor.white,
                                width: 93,
                                height: 93,
                                fit: BoxFit.cover,
                                errorBuilder: (_, error, stackTrace) {
                                  return Container(color: AppColor.white);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 12,
                      top: 10,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: AppColor.darkerYellow,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          height: 8,
                          width: 8,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xff00F261),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),

                    /// Show when a user want to edit
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          handleProfilePicture(context, provider);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // profile infor

          StreamBuilder<Users>(
            stream: provider.userProfile(context).asStream(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data!;
                //
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.fullName ?? '***',
                      style: style.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.width * 0.1,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) {
                                        return const ChangePassword();
                                      },
                                    );
                                  },
                                  child: editInfor(
                                    screenSize,
                                    'Password',
                                    Icons.security,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.1),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            UpdateProfile(userDetail: user),
                                      ),
                                    );
                                  },
                                  child: editInfor(
                                    screenSize,
                                    'Edit profile',
                                    Icons.edit,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                        ],
                      ),
                    ),
                    //

                    UserInforTile(
                      icon: Icons.person,
                      title: user.fullName ?? '***',
                      subTitle: 'Full Name',
                    ),

                    UserInforTile(
                      icon: Icons.person_outline,
                      title: user.userName ?? '***',
                      subTitle: 'UserName',
                    ),

                    UserInforTile(
                      icon: Icons.email,
                      title: user.email ?? '***',
                      subTitle: 'Email',
                    ),

                    UserInforTile(
                      icon: Icons.location_city,
                      title: user.countryState ?? '***',
                      subTitle: 'State',
                    ),

                    UserInforTile(
                      icon: Icons.location_on,
                      title: user.userCity ?? '***',
                      subTitle: 'City',
                    ),

                    UserInforTile(
                      icon: Icons.phone,
                      title: user.phoneNumber ?? '***',
                      subTitle: 'PhoneNo',
                    ),
                  ],
                );
              }
              return Text(
                'Loading...',
                style: style.copyWith(
                  color: AppColor.darkerGrey,
                ),
              );
            },
          ),
        ]),
      ),
    );
  }

  Container editInfor(Size screenSize, String title, IconData icon) {
    return Container(
      height: 36,
      //width: screenSize.width * 0.35,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColor.darkerYellow.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(title, style: style)
        ],
      ),
    );
  }

// A method that handles adding users profile picture
  Future<dynamic> handleProfilePicture(
      BuildContext context, UserData provider) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Popover(
          mainAxisSize: MainAxisSize.min,
          child: Column(children: [
            InkWell(
              onTap: () {
                provider.pickProfileImage(
                    source: ImageSource.camera,
                    profileImage: _profileImage,
                    context: context);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt_outlined),
                  const SizedBox(width: 10),
                  Text('CAMERA', style: style)
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                provider.pickProfileImage(
                    source: ImageSource.gallery,
                    profileImage: _profileImage,
                    context: context);

                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.photo_library_outlined),
                  const SizedBox(width: 10),
                  Text('GALLERY', style: style)
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
