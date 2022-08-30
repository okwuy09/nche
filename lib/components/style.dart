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

void successOperation(context) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(100),
        content: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_outlined,
                color: AppColor.white,
                //size: 2,
              ),
              const SizedBox(width: 10),
              Text(
                'Successful',
                style: style.copyWith(color: AppColor.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green.withOpacity(0.8),
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );

const googleApiKey = 'AIzaSyAd4rEAQqf5BfCJGABqW99teDPgBcuyN08';
//const googleAPIkey2 = 'AIzaSyCGShAceyIm1LHL2mLja0eKCKDjoZV2RzY';
