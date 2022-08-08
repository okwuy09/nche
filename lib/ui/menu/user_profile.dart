import 'package:flutter/material.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/mylisttile.dart';
import 'package:nche/services/provider.dart';
import 'package:nche/ui/authentication/signup_signin.dart';
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
    var provider = Provider.of<Authentication>(context, listen: true);
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
                        height: screenSize.height * 0.24,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColor.brown,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(screenSize.width, 80.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.close_outlined,
                                    color: AppColor.darkerYellow,
                                    size: 35,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tiana Rosser',
                                    style: style.copyWith(
                                      color: AppColor.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'User: ADX0032',
                                    style: style.copyWith(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: screenSize.width / 2.6,
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(130),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(130),
                          child: Image.asset(
                            'assets/musk.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  'assets/No_image.png',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 5,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: AppColor.brown,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: const Color(0xff00F261),
                                borderRadius: BorderRadius.circular(50)),
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
              icon: Icons.person_outline,
              title: 'Account Info',
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
