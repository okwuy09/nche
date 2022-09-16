import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/widget/button.dart';

class SearchDetails extends StatelessWidget {
  final UserFriends friendsData;
  const SearchDetails({Key? key, required this.friendsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        iconTheme: IconThemeData(color: AppColor.black),
        title: Text(
          'Search',
          style: style.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: friendsData.userFriends.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  Container(
                    //margin: const EdgeInsets.only(bottom: 10, top: 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    height: 72,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              friendsData.userFriends[index].name[0]
                                  .toUpperCase(),
                              style: style.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 65,
                          width: screenSize.width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friendsData.userFriends[index].name,
                                style: style.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColor.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                friendsData.userFriends[index].approved
                                    ? 'Approved the search'
                                    : 'Yet to approve search',
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
                        Icon(
                          Icons.check_circle_outline,
                          color: friendsData.userFriends[index].approved
                              ? Colors.green
                              : AppColor.orange,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                ],
              );
            },
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColor.darkerYellow,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: screenSize.width * 0.8,
                      child: Text(
                        'This buttom will only be active for 24hrs after search has been approved',
                        style: style.copyWith(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MainButton(
                  borderColor: Colors.transparent,
                  backgroundColor: AppColor.darkerYellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 5),
                      const Text('SEARCH FOR ALBERT'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
