//import 'dart:convert';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/progress_indicator.dart';
import 'package:nche/components/success_sheet.dart';
import 'package:nche/model/users.dart';
import 'package:nche/ui/authentication/phoneSignin/phone_otp.dart';
import 'package:nche/ui/authentication/signin/signin.dart';
import 'package:nche/ui/homepage/bottom_navbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  bool isnloading = false;
  final _firebaseAuth = FirebaseAuth.instance;

  // signIn With Google, function with firebase
  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      isnloading = true;
      notifyListeners();
      MyIndicator().waiting(context);
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        if (value.user != null) {
          /// create profile on signup using Phone Number
          final docUser = FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid);

          final user = Users(
            email: value.user!.email,
            fullName: value.user!.displayName,
            id: docUser.id,
            avarter: value.user!.photoURL,
          );
          final json = user.toJson();
          // create document and write data to firebase
          docUser.set(json);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNavBar(),
            ),
          );
        }

        isnloading = false;
        notifyListeners();
        // Once signed in, return the UserCredential
        return FirebaseAuth.instance.signInWithCredential(credential);
      });
    } on FirebaseAuthException catch (e) {
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

// signIn with phone Number function with firebase
  Future<void> signInWithPhoneNumber({
    required BuildContext context,
    required String mobile,
    String? sentCode,
  }) async {
    try {
      MyIndicator().waiting(context);
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        // verification completed
        verificationCompleted: (credential) async {
          await _firebaseAuth.signInWithCredential(credential).then((value) {
            if (value.user != null) {
              /// create profile on signup using Phone Number
              final docUser = FirebaseFirestore.instance
                  .collection('users')
                  .doc(value.user!.uid);

              final user = Users(
                email: value.user!.email,
                fullName: value.user!.displayName,
                id: docUser.id,
                avarter: value.user!.photoURL,
              );
              final json = user.toJson();
              // create document and write data to firebase
              docUser.set(json);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const BottomNavBar(),
                ),
              );
              notifyListeners();
            }
            // Once signed in, return the UserCredential
            return FirebaseAuth.instance.signInWithCredential(credential);
          });
        },
        // verification Failed
        verificationFailed: (e) {
          Navigator.pop(context);
          handleFireBaseAlert(
            context: context,
            message: e.message!,
          );
        },
        // verification code sent
        codeSent: (verificationId, resendToken) async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OTPAuthentication(
                phoneNumber: mobile,
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

  // Reset password
  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      isnloading = true;
      notifyListeners();
      MyIndicator().waiting(context);
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      Navigator.pop(context);
      handleSuccessfullOperation(
        message: 'Password Reset Email Sent Successfully',
        context: context,
        onTap: () => Navigator.pop(context),
      );
    } on FirebaseAuthException catch (e) {
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

// signIn function with firebase
  Future<String?> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isnloading = true;
      notifyListeners();
      MyIndicator().waiting(context);
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then(
        (value) {
          if (value.user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const BottomNavBar(),
              ),
            );
          }
        },
      );
      isnloading = false;
      notifyListeners();

      return 'Success';
    } on FirebaseAuthException catch (e) {
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

// signUp function with firebase
  Future signUp({
    required String email,
    required String password,
    required String fullName,
    required String userName,
    required BuildContext context,
  }) async {
    try {
      isnloading = true;
      notifyListeners();
      MyIndicator().waiting(context);
      var _userdata = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) {
        if (value.user != null) {
          /// create profile on signup using Email and password
          final docUser = FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid);
          final user = Users(
              email: email.trim(),
              fullName: fullName.trim(),
              id: docUser.id,
              userName: userName.trim(),
              avarter:
                  'https://firebasestorage.googleapis.com/v0/b/nche-application.appspot.com/o/avatar.png?alt=media&token=f70e3f9c-d432-4a03-b047-4ff97a245b52');
          final json = user.toJson();
          // create document and write data to firebase
          docUser.set(json);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNavBar(),
            ),
          );
        }
      });

      isnloading = false;
      notifyListeners();
      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(_userdata.credential!);
    } on FirebaseAuthException catch (e) {
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

  // signOut fuction with firebase
  Future<void> signOut({required BuildContext context}) async {
    await _firebaseAuth.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const SignIn();
        },
      ),
      (_) => false,
    );
  }
}