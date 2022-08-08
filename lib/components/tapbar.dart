import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/Feed/feed.dart';
import 'package:nche/ui/Feed/saved_feed.dart';
import 'package:nche/ui/menu/user_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyTapBar extends StatefulWidget {
  const MyTapBar({Key? key}) : super(key: key);
  @override
  _MyTapBarState createState() => _MyTapBarState();
}

class _MyTapBarState extends State<MyTapBar> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => pushNewScreen(
                          context,
                          screen: const UserProfile(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.darkerYellow,
                              backgroundImage:
                                  const AssetImage("assets/musk.jpg"),
                              maxRadius: 20,
                            ),
                            Positioned(
                              right: -1,
                              top: 5,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
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
                      Expanded(child: Container()),
                      SizedBox(
                        width: screenSize.width * 0.46,
                        child: CupertinoSearchTextField(
                          decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppColor.lightGrey),
                          ),
                          onChanged: (value) => {},
                          onSubmitted: (value) => {},
                        ),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        'assets/nche_logo.png',
                        width: 100,
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //
            Container(
              height: 43,
              margin: const EdgeInsets.only(
                  top: 15, bottom: 10, right: 20, left: 20),
              decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  border: Border.all(color: AppColor.lightGrey, width: 4),
                  borderRadius: BorderRadius.circular(6.0)),
              child: TabBar(
                labelStyle: style,
                indicator: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                labelColor: AppColor.black,
                unselectedLabelColor: AppColor.grey,
                tabs: const [
                  Tab(
                    text: 'My feed',
                  ),
                  Tab(
                    text: 'Save',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Feed(),
                  SaveFeed(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
