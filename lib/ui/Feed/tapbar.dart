import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/ui/Feed/feed_search.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/feed.dart';
import 'package:nche/ui/Feed/saved_feed.dart';
import 'package:nche/ui/Feed/write_post.dart';
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
    var provider = Provider.of<UserData>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.darkerYellow,
          elevation: 3,
          child: Icon(
            Icons.post_add_rounded,
            color: AppColor.brown,
            size: 28,
          ),
          onPressed: () => pushNewScreen(
            context,
            screen: const WritePost(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          ),
        ),
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
                              backgroundImage: provider
                                      .userData!.avarter!.isNotEmpty
                                  ? NetworkImage(provider.userData!.avarter!)
                                  : const AssetImage('assets/avatar.png')
                                      as ImageProvider,
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
                      Expanded(child: Container()),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          onTap: () => showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate(),
                          ),
                          child: Container(
                            height: 40,
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
                      Expanded(child: Container())
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
