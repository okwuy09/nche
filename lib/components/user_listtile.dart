import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';

class MyListTile extends StatelessWidget {
  final String subTitle;
  final String title;
  final Function()? onTap;
  const MyListTile({
    Key? key,
    required this.subTitle,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: style,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColor.grey,
      ),
      subtitle: Text(
        subTitle,
        style: style.copyWith(
          fontSize: 11,
          color: AppColor.grey,
        ),
      ),
    );
  }
}
