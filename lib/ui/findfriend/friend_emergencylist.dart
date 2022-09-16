import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/emergency_contact_friend.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/button.dart';
import 'package:provider/provider.dart';

class FriendEmergencyList extends StatelessWidget {
  final Users friends;
  const FriendEmergencyList({Key? key, required this.friends})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    List<EmergencyContactFriend> userFriendsList = [];
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.78,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Text(
                'Find Friend',
                style: style.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: AppColor.black,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          //const SizedBox(height: 10),
          Text(
            'Before you can search for a user on the app, you must get accreditation from at least three (3) people in his emergency contact list.',
            style: style,
          ),
          const SizedBox(height: 20),
          Text(
            '@${friends.fullName}',
            style: style.copyWith(
              fontSize: 18,
            ),
          ),
          // new list
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friends.emergencyContact!.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    //margin: const EdgeInsets.only(bottom: 10, top: 0),
                    padding: const EdgeInsets.symmetric(
                      //horizontal: 15,
                      vertical: 6,
                    ),
                    height: 55,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   backgroundColor: AppColor.white,
                        //   radius: 25,
                        //   backgroundImage:
                        //       NetworkImage(friends[index].avarter!),
                        // ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 50,
                          width: screenSize.width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friends.emergencyContact![index]['name'],
                                style: style.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.grey.withOpacity(0.6),
                            elevation: 0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Notify',
                                style: style.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                ],
              );
            },
          ),
          Expanded(child: Container()),
          MainButton(
              borderColor: AppColor.black,
              backgroundColor: AppColor.lightGrey,
              child: Text(
                'NOTIFY ALL FRIENDS',
                style: style.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                for (var i in friends.emergencyContact!) {
                  var friendList = EmergencyContactFriend(
                    approved: false,
                    phone: i['phone'],
                    name: i['name'],
                  );
                  userFriendsList.add(friendList);
                }
                provider.createSearch(
                  userId: provider.userData!.id,
                  userFriends: userFriendsList,
                  searchName: friends.fullName ?? 'Name Undefined',
                );
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
