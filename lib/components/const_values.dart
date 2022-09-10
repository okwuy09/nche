import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

// all states
const allNigeriaStates = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara",
  "FCT(Abuja)",
];

void successOperation(context) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(100),
        content: Row(
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
        backgroundColor: Colors.green.withOpacity(0.8),
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 3000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );

void locationNotification(context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // animation: Tween<double>(begin: 0, end: 300).animate(
        //     AnimationController(
        //         duration: const Duration(seconds: 5), vsync:  ),),

        duration: const Duration(seconds: 5),
        backgroundColor: AppColor.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 200),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Icon(
                    Icons.warning_amber,
                    size: 30,
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WARNING !!!',
                      style: style.copyWith(
                        color: AppColor.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      text,
                      style: style.copyWith(color: AppColor.black),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () async => await Geolocator.openLocationSettings(),
                child: Text(
                  'ENABLE',
                  style: style.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

const googleApiKey = 'AIzaSyDGGeVU35neK9m5l_GdCnP8u09zxSe3kJg';
