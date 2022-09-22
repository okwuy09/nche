import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/findfriend/search_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.black),
        title: Align(
          widthFactor: 1.5,
          child: Text(
            'Search History',
            style: style.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<UserFriends>>(
          stream: provider.fetchFriendSearch(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: buttonCircularIndicator);
            } else {
              var userFriend = snapshot.data!;
              var userFriends = userFriend
                  .where((e) => e.searcherId == provider.userData.id)
                  .toList();
              return userFriends.isEmpty
                  ? Container(
                      width: screenSize.width,
                      color: AppColor.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_outlined,
                            size: 100,
                            color: AppColor.grey.withOpacity(0.5),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'No search history',
                            style: style.copyWith(
                              color: AppColor.grey.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: userFriends.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      //physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.18,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) => provider
                                      .deleteSearch(userFriends[index].id),
                                  autoClose: true,
                                  borderRadius: BorderRadius.circular(6),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  backgroundColor: AppColor.white,
                                  foregroundColor: AppColor.red,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Container(
                              height: 80,
                              width: screenSize.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: AppColor.lightGrey,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: userFriends[index]
                                                  .isSuccessfull
                                              ? Colors.green.withOpacity(0.2)
                                              : AppColor.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          userFriends[index].isSuccessfull
                                              ? 'Successful Search'
                                              : 'Ongoing Search',
                                          style: style.copyWith(
                                            color:
                                                userFriends[index].isSuccessfull
                                                    ? Colors.green
                                                    : AppColor.blue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        userFriends[index].searchName,
                                        style: style.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color:
                                              AppColor.black.withOpacity(0.6),
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
                                          friendsData: userFriends[index],
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
                            ),
                          ),
                        );
                      },
                    );
            }
          }),
    );
  }
}
