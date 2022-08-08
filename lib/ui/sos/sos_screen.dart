import 'package:flutter/material.dart';
import 'package:nche/components/add_contact_sheet.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/success_sheet.dart';
import 'package:nche/ui/menu/user_profile.dart';
import 'package:nche/ui/sos/emergency_contact.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({Key? key}) : super(key: key);
  @override
  _SOSScreenState createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool selected = false;
  bool bottonComplete = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.brown,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => pushNewScreen(
                          context,
                          screen: const UserProfile(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.darkerYellow,
                              backgroundImage:
                                  const AssetImage("assets/musk.jpg"),
                              maxRadius: 20,
                            ),
                            Positioned(
                              right: -1,
                              top: 5,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  color: AppColor.brown,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff00F261),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        'Panic Button',
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColor.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        child: Icon(
                          Icons.more_vert,
                          color: AppColor.white,
                          size: 30,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SOS button
            Container(
              height: 310,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  AnimatedContainer(
                    height: selected ? 290 : 270,
                    width: selected ? 290 : 270,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInBack,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: AppColor.darkerYellow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(300),
                    ),
                  ),
                  Positioned(
                    top: 63,
                    right: 44,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          height: selected ? 200 : 180,
                          width: selected ? 200 : 180,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInBack,
                          decoration: BoxDecoration(
                            color: AppColor.darkerYellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(150),
                          ),
                        ),
                        Positioned(
                          top: 41,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              // sos button to be clicked
                              GestureDetector(
                                child: AnimatedContainer(
                                  height: selected ? 115 : 95,
                                  width: selected ? 115 : 95,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInBack,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? AppColor.white
                                        //const Color(0xffC7F8E3)
                                        : AppColor.darkerYellow,
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                  child: Center(
                                    child: bottonComplete
                                        ? Icon(Icons.check,
                                            size: 60,
                                            color: AppColor.darkerYellow
                                            //Color(0xff228E70),
                                            )
                                        : Text(
                                            'SOS',
                                            style: style.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                  ),
                                  onEnd: () {
                                    // Sent panic button notification to users on Animation complete
                                    setState(() {
                                      selected
                                          ? bottonComplete = !bottonComplete
                                          : bottonComplete = false;
                                    });
                                    bottonComplete
                                        ? handleSuccessfullOperation(
                                            context: context,
                                            message:
                                                'You Have Successfully Sent Emergency Notification To Your Friends.',
                                            onTap: () {
                                              setState(() {
                                                selected = false;
                                              });
                                              Navigator.pop(context);
                                            })
                                        : false;
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    selected = false;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    selected = true;
                                  });
                                },
                              ),

                              Text(
                                'Tap Here',
                                style: style.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.lightGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // cancel buton
            //SizedBox(height: screenSize.height * 0.05),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: MainButton(
            //     borderColor: Colors.transparent,
            //     text: bottonComplete ? 'SENT SUCCESSFULLY' : 'CANCEL',
            //     backgroundColor: AppColor.white,
            //     onTap: () {
            //       setState(() {
            //         selected = false;
            //       });
            //     },
            //   ),
            // ),

            //
            SizedBox(height: screenSize.height * 0.18),
            Container(
              height: screenSize.height * 0.18,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.15),
                border: Border.all(
                  color: AppColor.white.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Add Emergency\nNumber',
                        style: style.copyWith(
                            color: AppColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      Expanded(child: Container()),

                      // add new contact button
                      GestureDetector(
                        child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: const Color(0xff231F20),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: Icon(
                            Icons.person_add_outlined,
                            color: AppColor.darkerYellow,
                            size: 30,
                          ),
                        ),
                        onTap: () {
                          // add contact
                          handleAddContact(
                            context: context,
                            nameController: _fullName,
                            phoneController: _phoneNumber,
                            onTap: () {},
                          );
                        },
                      )
                    ],
                  ),

                  //
                  Expanded(child: Container()),
                  GestureDetector(
                    child: Text(
                      'View Emergency Contacts',
                      style: style.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmergencyContact(),
                      ),
                    ),
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
