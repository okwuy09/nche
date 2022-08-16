import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/users.dart';
import 'package:permission_handler/permission_handler.dart';

class UserData with ChangeNotifier {
  //bool noProfileUpdate = true;
  String userProfileImage = '';

  final User _user = FirebaseAuth.instance.currentUser!;
  final _firebaseStorage = FirebaseStorage.instance;

  Future<Users> userProfile(context) async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid) //'trCGMsdcg1MwjWyMHpgP'
        .get();

    var userProfileData = Users.fromJson(userDoc.data()!);
    userProfileImage = userProfileData.avarter!;
    notifyListeners();
    return userProfileData;
  }

// Change Password
  bool ischangePassword = false;
  Future changePassword(
    String currentPassword,
    String newPassword,
    BuildContext context,
  ) async {
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.
    try {
      ischangePassword = true;
      notifyListeners();
      final cred = EmailAuthProvider.credential(
          email: _user.email!, password: currentPassword);
      await _user.reauthenticateWithCredential(cred).then((value) async {
        await _user.updatePassword(newPassword).then((_) {
          // usersRef.doc(uid).update({"password": newPassword});
        });
      });
      ischangePassword = false;
      notifyListeners();
      Navigator.pop(context);
      successOperation(context, 'Password Updated Successfully');
    } on FirebaseAuthException catch (e) {
      ischangePassword = false;
      notifyListeners();
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

  // Edit Profile
  bool isUpdateProfile = false;
  updateUserProfile({
    String? email,
    String? fullName,
    String? userName,
    String? countryState,
    String? userCity,
    String? phoneNumber,
    required BuildContext context,
  }) async {
    try {
      isUpdateProfile = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .update({
        'email': email,
        'fullName': fullName,
        'userName': userName,
        'countryState': countryState,
        'userCity': userCity,
        'phoneNumber': phoneNumber,
      });
      isUpdateProfile = false;
      notifyListeners();
      Navigator.pop(context);

      successOperation(context, 'Profile Updated Successfully');
    } on FirebaseAuthException catch (e) {
      isUpdateProfile = false;
      notifyListeners();
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

// update user profile picture
  Future pickProfileImage({
    required ImageSource source,
    XFile? profileImage,
    required BuildContext context,
  }) async {
    final picker = ImagePicker();
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 50,
        maxHeight: 700,
        maxWidth: 650,
      );
      profileImage = pickedFile;
      notifyListeners();

      var file = File(profileImage!.path);
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/${profileImage.name}')
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      var userDoc = FirebaseFirestore.instance;
      userDoc
          .collection('users')
          .doc(_user.uid)
          .update({'avarter': downloadUrl});

      notifyListeners();
    }
  }
}
