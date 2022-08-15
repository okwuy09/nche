import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';

final style = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColor.black,
);

final buttonCircularIndicator = SizedBox(
  height: 25,
  width: 25,
  child: CircularProgressIndicator(
    backgroundColor: AppColor.lightGrey.withOpacity(0.6),
    valueColor: AlwaysStoppedAnimation(AppColor.white),
    strokeWidth: 4.0,
  ),
);

const googleApiKey = 'AIzaSyAd4rEAQqf5BfCJGABqW99teDPgBcuyN08';
//const googleAPIkey2 = 'AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY';
