import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/users.dart';

class UsersList extends StatelessWidget {
  final int index;
  final List<Users> users;
  final BuildContext context;
  const UsersList({
    Key? key,
    required this.context,
    required this.index,
    required this.users,
  }) : super(key: key);
  final bool isMYFriend = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      height: 70,
      width: screenSize.width,
      decoration: BoxDecoration(
          color: AppColor.lightGrey, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColor.white,
            radius: 30,
            backgroundImage: NetworkImage(users[index].avarter!),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 40,
            width: screenSize.width * 0.45,
            child: Center(
              child: Text(
                users[index].fullName!,
                style: style.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColor.darkerYellow,
              elevation: 0,
            ),
            child: Text(
              isMYFriend ? 'Friend' : 'Add Friend',
              style: style.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: isMYFriend ? null : () {},
          )
        ],
      ),
    );
  }
}
