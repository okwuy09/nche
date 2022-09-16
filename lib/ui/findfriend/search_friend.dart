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
    return Column(
      children: [
        Builder(builder: (context) {
          // user emergencylist
          var friends = provider.userData!.emergencyContact!;
          // generate a list of user emergency phone numbers
          var _userphone =
              List.generate(friends.length, (i) => friends[i]['phone'])
                  .toList();
          // filter the list of all users with a user emergency list
          var _users =
              users.where((e) => _userphone.contains(e.phoneNumber)).toList();
          return ListView.builder(
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
          );
        }),
        StreamBuilder<List<UserFriends>>(
          stream: provider.fetchFriendSearch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return buttonCircularIndicator;
            } else {
              var result = snapshot.data!;
              return Container(
                //height: screenSize.height * 0.3,
                width: screenSize.width,
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                color: AppColor.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Search history',
                          style: style.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColor.black.withOpacity(0.6),
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SearchHistory(userFriends: result),
                            ),
                          ),
                          child: Text(
                            'VIEW ALL',
                            style: style.copyWith(
                              color: AppColor.darkerYellow,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          width: screenSize.width,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.lightGrey,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(
                                          0.2), //AppColor.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Successful Search', //'Ongoing Search',
                                      style: style.copyWith(
                                        color: Colors.green, //AppColor.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    result[index].searchName,
                                    style: style.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColor.black.withOpacity(0.6),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SearchDetails(
                                        friendsData: result[index]),
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColor.darkerGrey,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
