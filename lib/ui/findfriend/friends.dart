import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/findfriend/friend_emergencylist.dart';
import 'package:provider/provider.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);
    var screenSize = MediaQuery.of(context).size;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColor.white,
              //height: screenSize.height * 0.5,
              child: StreamBuilder<List<Users>>(
                stream: provider.fetchUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return buttonCircularIndicator;
                  } else {
                    var friends = snapshot.data!;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              //margin: const EdgeInsets.only(bottom: 10, top: 0),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 6,
                              ),
                              height: 75,
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                  //color: AppColor.lightGrey,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.white,
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(friends[index].avarter!),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 65,
                                    width: screenSize.width * 0.45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          friends[index].fullName!,
                                          style: style.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          //'+12308065613896',
                                          friends[index].phoneNumber!,
                                          style: style.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.darkerGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.grey,
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Search',
                                          style: style.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                AppColor.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return FriendEmergencyList(
                                              friends: friends);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Divider(height: 0),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              //height: screenSize.height * 0.3,
              width: screenSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColor.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Searches',
                        style: style.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {},
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
                  const SizedBox(height: 15),
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80,
                        width: screenSize.width,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
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
                                const SizedBox(height: 10),
                                Text(
                                  'Albert Obiefuna',
                                  style: style,
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.darkerGrey,
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
