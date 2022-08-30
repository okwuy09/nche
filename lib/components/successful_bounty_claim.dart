import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/homepage/bottom_navbar.dart';
import 'package:nche/ui/homepage/reward_screen.dart';

handleSuccessfulBountyClaim({context}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return Container(
        margin: const EdgeInsets.all(20),
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
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BottomNavBar(),
                    ),
                    (route) => false),
                icon: const Icon(
                  Icons.close,
                ),
              ),
            ),
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
              'You have successfully submitted bounty for \$5000 reward.',
              style: style,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            MainButton(
              borderColor: Colors.transparent,
              child: Text(
                'CLAIM MORE',
                style: style.copyWith(
                  fontSize: 14,
                  color: const Color(0xff188A8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color(0xffD9FFF8),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RewardScreen(),
                ),
              ),
            ),

            //
            const SizedBox(height: 20),
            Text(
              'Only people in Your emergency contact and the agency will be notified.',
              style: style.copyWith(
                fontSize: 14,
                color: AppColor.darkerGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}
