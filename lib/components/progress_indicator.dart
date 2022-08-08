import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';

class MyIndicator {
  waiting(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoActivityIndicator(
              radius: 12,
            ),
          ),
        ),
      ),
    );
  }
}
