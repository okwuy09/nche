import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class UserInforTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Function()? onTap;
  const UserInforTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      title: Text(
        title,
        style: style,
      ),
      subtitle: Text(
        subTitle,
        style: style.copyWith(
          fontSize: 10,
          color: AppColor.grey,
        ),
      ),
      leading: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: AppColor.lighterOrange,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Icon(
          icon,
          color: AppColor.darkerYellow,
        ),
      ),
    );
  }
}
