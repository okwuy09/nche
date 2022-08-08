import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';

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
          ? screenSize.height * 0.15
          : screenSize.height * 0.1,
      width: screenSize.width * 0.4,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            height: 37,
            width: 37,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(45),
            ),
            child: icon,
          ),
          const SizedBox(width: 10),
          Text(title!)
        ],
      ),
    );
  }
}
