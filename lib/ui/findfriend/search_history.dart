import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/ui/findfriend/search_details.dart';

class SearchHistory extends StatelessWidget {
  final List<UserFriends> userFriends;
  const SearchHistory({Key? key, required this.userFriends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.black),
        title: Text(
          'Search History',
          style: style.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: userFriends.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        //physics: const NeverScrollableScrollPhysics(),
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
                        color: Colors.green
                            .withOpacity(0.2), //AppColor.blue.withOpacity(0.2),
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
                      userFriends[index].searchName,
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
                      builder: (_) =>
                          SearchDetails(friendsData: userFriends[index]),
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
      ),
    );
  }
}
