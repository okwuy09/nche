import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class NonActiveUsers extends StatelessWidget {
  const NonActiveUsers({
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
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    friends[index]['name'][0].toUpperCase(),
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
                      friends[index]['name'],
                      style: style.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColor.black.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      friends[index]['phone'],
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
                  primary: AppColor.grey,
                  elevation: 0,
                ),
                child: Row(
                  children: [
                    Text(
                      'Invite',
                      style: style.copyWith(
                        fontSize: 15,
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
