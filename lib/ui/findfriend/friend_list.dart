import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class nonActiveUsers extends StatelessWidget {
  const nonActiveUsers({
    Key? key,
    required this.friends,
    required this.index,
  }) : super(key: key);

  final List friends;
  final int index;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          //margin: const EdgeInsets.only(bottom: 10, top: 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          height: 80,
          width: screenSize.width,
          decoration: BoxDecoration(
            //color: AppColor.lightGrey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    friends[index]['name'][0].toUpperCase(),
                    style: style.copyWith(
                      fontSize: 25,
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
                      friends[index]['name'],
                      style: style.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      friends[index]['phone'],
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
                      'Invite',
                      style: style.copyWith(
                        //fontSize: 14,
                        //fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // showBottomSheet(
                  //   context: context,
                  //   builder: (_) =>
                  //       FriendEmergencyList(
                  //     friends: newfrinds,
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
