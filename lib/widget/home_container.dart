import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class HomeContainer extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final Color? iconBackgroundColor;

  const HomeContainer(
      {Key? key,
      required this.icon,
      required this.iconBackgroundColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.width > 600
          ? screenSize.height * 0.14
          : screenSize.height * 0.09,
      width: screenSize.width * 0.432,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(45),
            ),
            child: icon,
          ),
          const SizedBox(width: 8),
          Text(
            title!,
            style: style.copyWith(
              color: AppColor.black.withOpacity(0.6),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
