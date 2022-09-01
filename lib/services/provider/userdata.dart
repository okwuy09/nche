import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nche/components/alert.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/model/users.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as paths;

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
      successOperation(context);
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
      await FirebaseFirestore.instance
          .collection('posts')
          .where('sender.id', isEqualTo: userData!.id)
          .get()
          .then((value) => value.docs.forEach((doc) {
                doc.reference.update({'sender.userName': userName});
              }));
      isUpdateProfile = false;
      notifyListeners();
      Navigator.pop(context);

      successOperation(context);
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
  Future updateProfileImage({
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
      var _userDoc = FirebaseFirestore.instance;
      _userDoc
          .collection('users')
          .doc(_user.uid)
          .update({'avarter': downloadUrl});

      notifyListeners();
      _userDoc
          .collection('posts')
          .where('sender.id', isEqualTo: userData!.id)
          .get()
          .then((value) => value.docs.forEach((doc) {
                doc.reference.update({'sender.avarter': downloadUrl});
              }));

      notifyListeners();
    }
  }

  /// apps full data
  bool isPosting = false;
  Future writePost({
    required String writeUp,
    required BuildContext context,
    required String location,
    required bool isAnonymous,
    required String incidentType,
    List<File>? avarter,
    XFile? camImage,
  }) async {
    try {
      isPosting = true;
      notifyListeners();
      List images = [];

      // if the conditions are through upload picture from
      // camera and post else send post without image
      if (avarter!.isEmpty && camImage != null) {
        var file = File(camImage.path);
        var snapshot = await _firebaseStorage
            .ref()
            .child('PostImages/${camImage.path}')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        images.add(downloadUrl);
      } else {
        for (var img in avarter) {
          var snapshot = _firebaseStorage
              .ref()
              .child('PostImages/${paths.basename(img.path)}');
          await snapshot.putFile(img).whenComplete(() async {
            var downloadUrl = await snapshot.getDownloadURL();
            images.add(downloadUrl);
          });
        }
      }

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
        avarter: images,
        location: location,
        isAnanymous: isAnonymous,
        incidentType: incidentType,
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

  // delete your post
  Future deletePost(String docID, BuildContext context) async {
    await _firebaseStore.collection('posts').doc(docID).delete().then(
          (value) => successOperation(context),
        );
    notifyListeners();
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
