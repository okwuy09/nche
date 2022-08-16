import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';

class SocialButton extends StatelessWidget {
  final Widget title;
  final String assetUrl;
  const SocialButton({Key? key, required this.assetUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 140,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetUrl,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 13),
          title
        ],
      ),
    );
  }
}
