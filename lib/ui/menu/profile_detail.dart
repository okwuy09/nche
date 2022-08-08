import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/user_listtile.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                            bottom: Radius.elliptical(screenSize.width, 100.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: AppColor.white,
                                      size: 30,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: AppColor.darkerYellow,
                                      size: 30,
                                    ),
                                  ),
                                ],
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
              title: 'Tiana Rosser',
              subTitle: 'Full Name',
              onTap: () {},
            ),

            //
            const Divider(),
            MyListTile(
              title: 'United State of America',
              subTitle: 'Country',
              onTap: () {},
            ),

            //
            const Divider(),
            MyListTile(
              title: '+38762123456',
              subTitle: 'Phone Number',
              onTap: () {},
            ),

            //
            const Divider(),
            MyListTile(
              title: '************',
              subTitle: 'Password',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
