import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/findfriend/friend_list.dart';
import 'package:nche/ui/findfriend/search_friend.dart';
import 'package:nche/widget/button.dart';
import 'package:provider/provider.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.lightGrey,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Find Friend',
              style: style.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          //height: screenSize.height * 0.5,
          child: StreamBuilder<List<Users>>(
            stream: provider.fetchUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return buttonCircularIndicator;
              } else {
                var _users = snapshot.data!;
                var friends = provider.userData!.emergencyContact!;
                var _usersPhone = List<String>.generate(
                    _users.length, (i) => _users[i].phoneNumber!).toList();

                return Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return _usersPhone.contains(friends[index]['phone'])
                            ? Container()
                            : nonActiveUsers(
                                friends: friends,
                                index: index,
                              );
                      },
                    ),
                    SearchFriend(users: _users)
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
