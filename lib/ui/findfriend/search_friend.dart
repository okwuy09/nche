import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/findfriend/friend_emergencylist.dart';
import 'package:nche/ui/findfriend/search_details.dart';
import 'package:nche/ui/findfriend/search_history.dart';
import 'package:provider/provider.dart';

class SearchFriend extends StatelessWidget {
  final List<Users> users;
  const SearchFriend({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // provider to access user data
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);

    // user emergencylist
    var friends = provider.userData.emergencyContact ?? [];
    // generate a list of user emergency phone numbers
    var _userphone =
        List.generate(friends.length, (i) => friends[i]['phone']).toList();
    // filter the list of all users with a user emergency list
    var _users =
        users.where((e) => _userphone.contains(e.phoneNumber)).toList();
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 7,
                  ),
                  height: 72,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColor.white,
                        backgroundImage: NetworkImage(_users[index].avarter!),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 60,
                        width: screenSize.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _users[index].fullName!,
                              style: style.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColor.black.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _users[index].phoneNumber!,
                              style: style.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.darkerGrey.withOpacity(0.8),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.darkerYellow,
                          elevation: 0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Search',
                              style: style.copyWith(
                                fontSize: 15,
                                color: AppColor.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => FriendEmergencyList(
                              friends: _users[index],
                              friendContext: context,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
              ],
            );
          },
        ),
      ],
    );
  }
}
