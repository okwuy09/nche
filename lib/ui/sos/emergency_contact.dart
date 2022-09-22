import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/components/update_contact.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:provider/provider.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    // create variable to access login user information
    var user = provider.userData.emergencyContact;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.black),
        backgroundColor: AppColor.lightGrey,
        toolbarHeight: 60,
        elevation: 0,
        title: Text(
          'Emergency Contact',
          style: style.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: user!.isEmpty
          ? Center(
              child: Container(
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
              ),
            )
          : ListView.builder(
              itemCount: user.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: ((_) => UpdateEmergencyContact(
                                    fullname: user[index]['name'],
                                    phoneNo: user[index]['phone'],
                                  )),
                            ),
                            autoClose: true,
                            borderRadius: BorderRadius.circular(6),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: AppColor.white,
                            foregroundColor: AppColor.blue,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          const SizedBox(width: 5),
                          SlidableAction(
                            onPressed: (_) {
                              provider.deleteEmergencyContact(
                                name: user[index]['name'],
                                phone: user[index]['phone'],
                                context: context,
                              );
                            },
                            autoClose: true,
                            borderRadius: BorderRadius.circular(6),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            backgroundColor: AppColor.white,
                            foregroundColor: AppColor.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        height: 75,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Colors
                                    .primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  user[index]['name'][0].toUpperCase(),
                                  style: style.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
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
                                    user[index]['name'][0].toUpperCase() +
                                        user[index]['name'].substring(1),
                                    style: style.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColor.black.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    user[index]['phone'],
                                    style: style.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          AppColor.darkerGrey.withOpacity(0.8),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                  ],
                );
              },
            ),
    );
  }
}
