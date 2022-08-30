import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/ui/Feed/feed_search.dart';
import 'package:nche/components/style.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/feed.dart';
import 'package:nche/ui/Feed/saved_feed.dart';
import 'package:nche/ui/menu/user_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: AppColor.white,
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
                              backgroundImage: NetworkImage(
                                Provider.of<UserData>(context)
                                    .userData!
                                    .avarter!,
                              ),
                              maxRadius: 20,
                              onBackgroundImageError: (exception, stackTrace) =>
                                  Image.asset('assets/avatar.png'),
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
                      const SizedBox(width: 50),
                      Expanded(
                        child: InkWell(
                          onTap: () => showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate(),
                          ),
                          child: Container(
                            height: screenSize.height * 0.05,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColor.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Search',
                                  style: style.copyWith(
                                    color: AppColor.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
