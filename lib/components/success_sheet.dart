import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

handleSuccessfullOperation({
  context,
  Function()? onTap,
  required String message,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (_) {
      return Container(
        margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 109,
                  width: 109,
                  decoration: BoxDecoration(
                    color: AppColor.lighterOrange,
                    borderRadius: BorderRadius.circular(130),
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 18,
                  child: Container(
                    height: 71,
                    width: 71,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.darkerYellow),
                      borderRadius: BorderRadius.circular(130),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: AppColor.darkerYellow,
                    ),
                  ),
                ),
              ],
            ),

            //
            const SizedBox(height: 40),
            Text(
              message,
              style: style,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MainButton(
              borderColor: Colors.transparent,
              child: Text(
                'Continue',
                style: style.copyWith(
                  fontSize: 14,
                  color: AppColor.black,
                ),
              ),
              backgroundColor: AppColor.darkerYellow,
              onTap: onTap,
            ),
          ],
        ),
      );
    },
  );
}
