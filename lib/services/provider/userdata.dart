import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/model/users.dart';
import 'package:permission_handler/permission_handler.dart';

class UserData with ChangeNotifier {
  //bool noProfileUpdate = true;
  Users? userData;

  final User _user = FirebaseAuth.instance.currentUser!;
  final _firebaseStorage = FirebaseStorage.instance;
  final _firebaseStore = FirebaseFirestore.instance;

  // share post to social media
  bool isSharing = false;
  Future sharePost({required String imageUrl, required String text}) async {
    isSharing = false;
    notifyListeners();
    // final response = await http.get(Uri.parse(imageUrl));
    // final temp = await getTemporaryDirectory();
    // final path = '${temp.path}/image.jpg';
    // File(path).writeAsBytesSync(response.bodyBytes);
    await Share.shareWithResult('$text, $imageUrl',
        subject: 'Security Update From Nche App');
    isSharing = false;
    notifyListeners();
  }

  /// fetch user profile
  Future<Users> userProfile(context) async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid) //'trCGMsdcg1MwjWyMHpgP'
        .get();

    var userProfileData = Users.fromJson(userDoc.data()!);
    userData = userProfileData;
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

  /// apps full data
  bool isPosting = false;
  Future writePost({
    required String writeUp,
    required BuildContext context,
  }) async {
    try {
      isPosting = true;
      notifyListeners();

      /// create new post
      final postDoc = FirebaseFirestore.instance.collection('posts').doc();
      final posts = FeedPost(
        id: postDoc.id,
        sender: userData!,
        time: DateTime.now(),
        writeUp: writeUp,
        upLike: [],
        downLike: [],
        savePost: [],
      );
      final json = posts.toJson();
      postDoc.set(json);

      isPosting = false;
      notifyListeners();
      return;
    } on FirebaseAuthException catch (e) {
      isPosting = false;
      notifyListeners();
      return handleFireBaseAlert(
        context: context,
        message: e.message!,
      );
    }
  }

  // Fetch feed posts from firebase
  Stream<List<FeedPost>> fetchPost() {
    var postDoc = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => FeedPost.fromJson(doc.data())).toList());

    return postDoc;
  }

  //save post/ bookmark a favourite post
  Future savePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'save_post': FieldValue.arrayUnion([userData!.id]),
    });
  }

  //remove save post/ unbookmark a favourite post
  Future removeSavePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'save_post': FieldValue.arrayRemove([userData!.id]),
    });
  }

  //uplike in post
  Future upLikePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'upLike': FieldValue.arrayUnion([userData!.id]),
    });
  }

  //removeUplike in post
  Future removeUpLikePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'upLike': FieldValue.arrayRemove([userData!.id]),
    });
  }

  //Downlike in post
  Future downLikePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'downLike': FieldValue.arrayUnion([userData!.id]),
    });
  }

  //removeUplike in post
  Future removeDownLikePost(String docID) async {
    _firebaseStore.collection('posts').doc(docID).update({
      'downLike': FieldValue.arrayRemove([userData!.id]),
    });
  }
}
