import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/ui/Feed/tapbar.dart';
import 'package:nche/ui/authentication/signin/signin.dart';
import 'package:nche/ui/findfriend/friends.dart';
import 'package:nche/ui/homepage/home_page.dart';
import 'package:nche/ui/notification/notification.dart';
import 'package:nche/ui/sos/sos_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

PersistentTabController? _controller;

class _BottomNavBarState extends State<BottomNavBar> {
  //bool? _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    //_hideNavBar = false;
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          AppColor.white, //const Color(0xff1D1416), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const HomePage(),
    const MyTapBar(),
    const SOSScreen(),
    const NotificationScreen(),
    const Friends(),
    //const FindFriend()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      title: "Home",
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black.withOpacity(0.6),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.feed_outlined),
      title: ("Feed"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black.withOpacity(0.6),
    ),
    PersistentBottomNavBarItem(
      icon: Container(
        height: 40,
        width: 45,
        decoration: BoxDecoration(
          color: AppColor.brown,
          border: Border.all(
            color: AppColor.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(130),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text(
              'SOS',
              style: style.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      title: ("Panic button"),
      activeColorPrimary: AppColor.brown,
      inactiveColorPrimary: AppColor.black.withOpacity(0.6),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.notifications_active_outlined),
      title: ("Notifs"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black.withOpacity(0.6),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_search_outlined),
      title: ("Find Friend"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black.withOpacity(0.6),
    ),
  ];
}
