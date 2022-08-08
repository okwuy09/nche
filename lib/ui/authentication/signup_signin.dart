// import 'package:flutter/material.dart';
// import 'package:nche/components/button.dart';
// import 'package:nche/components/colors.dart';
// import 'package:nche/ui/authentication/signin/signin.dart';
// import 'package:nche/ui/authentication/signup/signup.dart';

// class SignUpSignIn extends StatefulWidget {
//   const SignUpSignIn({Key? key}) : super(key: key);

//   @override
//   _SignUpSignInState createState() => _SignUpSignInState();
// }

// class _SignUpSignInState extends State<SignUpSignIn> {
//   @override
//   Widget build(BuildContext context) {
//     var screensize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(child: Container()),
//           SizedBox(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: screensize.height * 0.5,
//                         width: screensize.width * 0.8,
//                         decoration: BoxDecoration(
//                           color: AppColor.primaryColor,
//                           borderRadius:
//                               const BorderRadius.all(Radius.elliptical(20, 20)),
//                         ),
//                         // child: Center(
//                         //   child: Image.asset('assets/Logo.png',
//                         //       width: 195, height: 63),
//                         // ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: screensize.height * 0.12,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//             child: MainButton(
//               text: 'CREATE ACCOUNT',
//               backgroundColor: AppColor.primaryColor,
//               borderColor: Colors.transparent,
//               onTap: () => Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const SignUp())),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//             child: MainButton(
//               text: 'SIGN IN',
//               backgroundColor: AppColor.lightGrey,
//               borderColor: Colors.transparent,
//               onTap: () => Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const SignIn())),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: const Text(
//               'By tapping Create an account and using Nche, you agree to our  TERMS  and  PRIVACY POLICY.',
//               textAlign: TextAlign.center,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
