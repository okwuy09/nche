import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

handleFireBaseAlert({context, required String message}) {
  return showDialog(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            backgroundColor: AppColor.lightGrey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Center(
              child: Text(
                'ALERT !!!',
                style: style.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.red,
                ),
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: style.copyWith(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'OK',
                  style: style.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      );
    },
  );
}

handleLogOutAlert({
  context,
  required String message,
  required Function()? onPressed,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            backgroundColor: AppColor.lightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Center(
              child: Text(
                'ALERT !!!',
                style: style.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.red,
                ),
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: style.copyWith(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'CANCEL',
                      style: style.copyWith(
                        color: AppColor.darkerGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: style.copyWith(
                        color: AppColor.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    },
  );
}
