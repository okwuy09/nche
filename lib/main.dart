import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/services/provider/authentication.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/authentication/onboarding/onboardingscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nche/ui/authentication/signin/signin.dart';
import 'package:nche/ui/homepage/bottom_navbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Call the sharedPreferences when the app initialized to determine the bool condition of page to show.
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Authentication()),
    ChangeNotifierProvider(create: (_) => UserData()),
  ], child: MyApp(showHome: showHome)));
}

class MyApp extends StatelessWidget {
  final bool? showHome;
  const MyApp({Key? key, this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nche',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.black,
        ),
        appBarTheme: const AppBarTheme(elevation: 0),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColor.white,
        ),
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? showHome!
              ? const SignIn()
              : const OnboardingPage()
          : const BottomNavBar(),
    );
  }
}
