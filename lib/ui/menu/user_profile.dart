import 'package:flutter/material.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/widget/mylisttile.dart';
import 'package:nche/services/provider/authentication.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/menu/profile_detail.dart';
import 'package:nche/ui/menu/terms_condition.dart';
import 'package:nche/ui/menu/wallet.dart';
import 'package:nche/ui/notification/notification.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    'Account Detail',
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
                              color: AppColor.darkerYellow,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Positioned(
                            top: 3.5,
                            left: 3.5,
                            child: CircleAvatar(
                              backgroundColor: AppColor.white,
                              radius: 46,
                              backgroundImage: Provider.of<UserData>(context)
                                      .userData!
                                      .avarter!
                                      .isNotEmpty
                                  ? NetworkImage(
                                      Provider.of<UserData>(context)
                                          .userData!
                                          .avarter!,
                                    )
                                  : const AssetImage('assets/avatar.png')
                                      as ImageProvider,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 15,
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
                    ],
                  ),
                ),
              ],
            ),
            // profile infor

            MyListTile(
              icon: Icons.account_circle_outlined,
              title: 'Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileDetail(),
                  ),
                );
              },
            ),

            //
            const Divider(),
            MyListTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              ),
            ),

            //
            const Divider(),
            MyListTile(
              icon: Icons.account_balance_wallet_outlined,
              title: 'My Wallet',
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const MyWallet())),
            ),

            //
            const Divider(),
            MyListTile(
              icon: Icons.lock_outline,
              title: 'Terms of Service',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TermsAndCondition(),
                ),
              ),
            ),

            //
            const Divider(),
            MyListTile(
              icon: Icons.help_outline,
              title: 'Help',
              onTap: () {},
            ),

            //
            const Divider(),
            MyListTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),

            //
            const Divider(),
            const SizedBox(height: 30),
            MyListTile(
              icon: Icons.logout_outlined,
              title: 'Log Out',
              onTap: () {
                handleLogOutAlert(
                  message: 'Are you sure you want to LogOut',
                  context: context,
                  onPressed: () async {
                    await provider.signOut(context: context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
