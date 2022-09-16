import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
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

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController? _controller;

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
      backgroundColor: AppColor.grey.withOpacity(
          0.4), //const Color(0xff1D1416), // Default is Colors.white.
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
          NavBarStyle.style5, // Choose the nav bar style with this property.
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
      inactiveColorPrimary: AppColor.black,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.feed_outlined),
      title: ("Feed"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: {
          '/first': (context) => const HomePage(),
          '/second': (context) => const SignIn(),
        },
      ),
    ),
    PersistentBottomNavBarItem(
      icon: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.black),
          borderRadius: BorderRadius.circular(130),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text(
              'SOS',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),

      //Icon(Icons.add),
      //title: ("Add"),
      activeColorPrimary: AppColor.darkerYellow,
      activeColorSecondary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: {
          '/first': (context) => const HomePage(),
          '/second': (context) => const SignIn(),
        },
      ),
      // onPressed: (context) {
      //   // pushDynamicScreen(context!,
      //   //     screen: SampleModalScreen(), withNavBar: true);
      // },
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.notifications_active_outlined),
      title: ("Notification"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: {
          '/first': (context) => const HomePage(),
          '/second': (context) => const SignIn(),
        },
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_search_outlined),
      title: ("Person"),
      activeColorPrimary: AppColor.darkerYellow,
      inactiveColorPrimary: AppColor.black,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: {
          '/first': (context) => const HomePage(),
          '/second': (context) => const SignIn(),
        },
      ),
    ),
  ];
}
