import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nche/components/colors.dart';
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
  bool servicestatus = false;
  bool haspermission = false;
  Position? locationPosition;
  Map<PolylineId, Polyline> polylines = {};
  LatLng destination = const LatLng(6.4096, 7.4978);

  // display polyline inside te map
  // on user changes
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(locationPosition!.latitude, locationPosition!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    } else {
      (result.errorMessage);
    }
    PolylineId id = const PolylineId("nche");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColor.orange,
      points: polylineCoordinates,
      width: 6,
      geodesic: true,
      jointType: JointType.round,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  // check user Gps cordinate location,
  // onces a user open the application
  checkGps(context) async {
    late LocationPermission permission;
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationPosition = await Geolocator.getLastKnownPosition();
          notifyListeners();
        } else if (permission == LocationPermission.deniedForever) {
          //print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        locationPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        notifyListeners();

        late LocationSettings locationSettings;
        //  = const LocationSettings(
        //   accuracy: LocationAccuracy.best,
        //   distanceFilter: 100,
        // );

        if (defaultTargetPlatform == TargetPlatform.android) {
          locationSettings = AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
            forceLocationManager: true,
            //intervalDuration: const Duration(seconds: 10),
            //(Optional) Set foreground notification config to keep the app alive
            //when going to the background
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText: "Nche is updating your location",
              notificationTitle: "Tracking",
              enableWakeLock: true,
            ),
          );
        } else if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          locationSettings = AppleSettings(
            accuracy: LocationAccuracy.high,
            activityType: ActivityType.fitness,
            distanceFilter: 100,
            pauseLocationUpdatesAutomatically: true,
            // Only set to true if our app will be started up in the background.
            showBackgroundLocationIndicator: true,
          );
        } else {
          locationSettings = const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
          );
        }

        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
          locationPosition = position;
          _getPolyline();
          _firebaseStore.collection('users').doc(_user.uid).update(
            {'location': GeoPoint(position.latitude, position.longitude)},
          );
          notifyListeners();
        });
      }
    } else {
      locationNotification(
        context,
        'Enable device location services',
      );
    }

    notifyListeners();
  }

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
    var userDoc = await _firebaseStore
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
      await _firebaseStore.collection('users').doc(_user.uid).update({
        'email': email,
        'fullName': fullName,
        'userName': userName,
        'countryState': countryState,
        'userCity': userCity,
        'phoneNumber': phoneNumber,
      });
      await _firebaseStore
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
      var _userDoc = _firebaseStore;
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
      final postDoc = _firebaseStore.collection('posts').doc();
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
    var postDoc = _firebaseStore
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => FeedPost.fromJson(doc.data())).toList());

    return postDoc;
  }

  // Fetch feed posts from firebase
  Stream<List<Users>> fetchUsers() {
    var usersDoc = _firebaseStore.collection('users').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

    return usersDoc;
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
