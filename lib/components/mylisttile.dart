import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  const MyListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: style.copyWith(fontSize: 15),
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
