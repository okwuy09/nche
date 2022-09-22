import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/findfriend/non_active_users.dart';
import 'package:nche/ui/findfriend/search_details.dart';
import 'package:nche/ui/findfriend/search_friend.dart';
import 'package:nche/ui/findfriend/search_history.dart';
import 'package:provider/provider.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        automaticallyImplyLeading: false,
        title: Text(
          'Find Friend',
          style: style.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.white,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.48,
                child: StreamBuilder<List<Users>>(
                  stream: provider.fetchUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColor.darkerYellow,
                      ));
                    } else {
                      var _users = snapshot.data!;
                      var friends = provider.userData.emergencyContact!;
                      var _usersPhone = List<String>.generate(
                              _users.length, (i) => _users[i].phoneNumber!)
                          .toList();

                      return friends.isEmpty
                          ? Container(
                              color: AppColor.white,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_box_outline_blank_outlined,
                                      size: 80,
                                      color: AppColor.grey.withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'No Emergency Contact.\n Please add emergency contact.',
                                      style: style.copyWith(
                                        color: AppColor.grey.withOpacity(0.5),
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: friends.length,
                                  itemBuilder: (context, index) {
                                    return _usersPhone
                                            .contains(friends[index]['phone'])
                                        ? Container()
                                        : NonActiveUsers(
                                            friends: friends,
                                            index: index,
                                          );
                                  },
                                ),
                                SearchFriend(users: _users),
                              ],
                            );
                    }
                  },
                ),
              ),
              Container(
                //height: screenSize.height * 0.3,
                width: screenSize.width,
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                color: AppColor.lightGrey.withOpacity(0.3),
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
                              builder: (_) => const SearchHistory(),
                            ),
                          ),
                          child: Text(
                            'VIEW ALL ',
                            style: style.copyWith(
                              color: AppColor.darkerYellow,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<UserFriends>>(
                      stream: provider.fetchFriendSearch(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: buttonCircularIndicator,
                          );
                        } else {
                          var results = snapshot.data!;
                          var result = results
                              .where(
                                  (e) => e.searcherId == provider.userData.id)
                              .toList();
                          return result.isEmpty
                              ? SizedBox(
                                  height: screenSize.height * 0.255,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_outlined,
                                          size: 80,
                                          color: AppColor.grey.withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'No search history',
                                          style: style.copyWith(
                                            color:
                                                AppColor.grey.withOpacity(0.5),
                                          ),
                                        )
                                      ]),
                                )
                              : ListView.builder(
                                  itemCount: result.take(2).length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 80,
                                      width: screenSize.width,
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: AppColor.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: result[index]
                                                          .isSuccessfull
                                                      ? Colors.green
                                                          .withOpacity(0.2)
                                                      : AppColor.blue
                                                          .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  result[index].isSuccessfull
                                                      ? 'Successful Search'
                                                      : 'Ongoing Search',
                                                  style: style.copyWith(
                                                    color: result[index]
                                                            .isSuccessfull
                                                        ? Colors.green
                                                        : AppColor.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                result[index].searchName,
                                                style: style.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: AppColor.black
                                                      .withOpacity(0.6),
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
                                                  friendsData: result[index],
                                                ),
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
                                );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
