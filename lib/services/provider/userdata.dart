import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/progress_indicator.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/success_sheet.dart';
import 'package:nche/model/users.dart';
import 'package:nche/ui/menu/profile_detail.dart';
import 'package:permission_handler/permission_handler.dart';

class UserData with ChangeNotifier {
  bool isnloading = false;
  bool noProfileUpdate = true;
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

  // Edit Profile
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
      isnloading = true;
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
      isnloading = false;
      notifyListeners();
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColor.white,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              'Profile Updated Successfully',
              style: style.copyWith(color: AppColor.white),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 5000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ));
    } on FirebaseAuthException catch (e) {
      isnloading = false;
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

      noProfileUpdate = true;
      notifyListeners();
    }
  }
}
