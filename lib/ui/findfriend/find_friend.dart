// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nche/model/users.dart';
// import 'package:nche/ui/findfriend/search_friend.dart';
// import 'package:nche/widget/button.dart';
// import 'package:nche/components/colors.dart';
// import 'package:nche/components/const_values.dart';
// import 'package:nche/model/friends_contact.dart';
// import 'package:nche/services/provider/userdata.dart';
// import 'package:nche/ui/findfriend/mapscreen.dart';
// import 'package:nche/ui/menu/user_profile.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';

// class FindFriend extends StatefulWidget {
//   const FindFriend({Key? key}) : super(key: key);
//   @override
//   _FindFriendState createState() => _FindFriendState();
// }

// class _FindFriendState extends State<FindFriend> {
//   Users _selectedContact = Users(
//       id: '',
//       fullName: 'No name',
//       phoneNumber: 'No phone',
//       location: const GeoPoint(6.4096, 7.4978));
//   bool selected = false;
//   bool bottonComplete = false;
//   // ignore: prefer_final_fields
//   // List<SavedContact> _contact = [
//   //   SavedContact(
//   //     fullname: '0kwuchukwu Maduka',
//   //     phoneNumber: '08067613896',
//   //   ),
//   //   SavedContact(
//   //     fullname: 'Okoli okeychukwu',
//   //     phoneNumber: '08035613196',
//   //   ),
//   //   SavedContact(
//   //     fullname: 'Just Ruth',
//   //     phoneNumber: '08025613896',
//   //   ),
//   //   SavedContact(
//   //     fullname: 'UcheNna Okeke',
//   //     phoneNumber: '08065613896',
//   //   ),
//   //   SavedContact(
//   //     fullname: 'Ebuka Ifeanyi',
//   //     phoneNumber: '08052613896',
//   //   ),
//   //   SavedContact(
//   //     fullname: 'Chidi Okolo',
//   //     phoneNumber: '08095613896',
//   //   ),
//   // ];
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
//           selected = !selected;
//         }));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var provider = Provider.of<UserData>(context);
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       body: SingleChildScrollView(
//         child: StreamBuilder<List<Users>>(
//           stream: provider.fetchUsers(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return buttonCircularIndicator;
//             } else {
//               var users = snapshot.data!;
//               return Column(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(top: 50, left: 20, right: 20),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () => pushNewScreen(
//                                 context,
//                                 screen: const UserProfile(),
//                                 withNavBar:
//                                     false, // OPTIONAL VALUE. True by default.
//                                 pageTransitionAnimation:
//                                     PageTransitionAnimation.cupertino,
//                               ),
//                               child: Stack(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: AppColor.darkerYellow,
//                                     backgroundImage: provider
//                                             .userData!.avarter!.isNotEmpty
//                                         ? NetworkImage(
//                                             provider.userData!.avarter!)
//                                         : const AssetImage('assets/avatar.png')
//                                             as ImageProvider,
//                                     maxRadius: 20,
//                                     onBackgroundImageError:
//                                         (exception, stackTrace) =>
//                                             Image.asset('assets/avatar.png'),
//                                   ),
//                                   Positioned(
//                                     right: -1,
//                                     top: 5,
//                                     child: Container(
//                                       height: 12,
//                                       width: 12,
//                                       decoration: BoxDecoration(
//                                         color: AppColor.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Container(
//                                         height: 8,
//                                         width: 8,
//                                         margin: const EdgeInsets.all(2),
//                                         decoration: BoxDecoration(
//                                             color: const Color(0xff00F261),
//                                             borderRadius:
//                                                 BorderRadius.circular(50)),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(child: Container()),
//                             Text(
//                               'Find Friend',
//                               style: style.copyWith(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             Expanded(child: Container()),
//                             InkWell(
//                               // onTap: (() => showSearch(
//                               //       context: context,
//                               //       delegate: SearchFriends(),
//                               //     )),
//                               child: Icon(
//                                 Icons.search,
//                                 color: AppColor.darkerGrey,
//                                 size: 30,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Location Icon button
//                   Container(
//                     height: 250,
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     child: Stack(
//                       children: [
//                         AnimatedContainer(
//                           height: selected ? 240 : 200,
//                           width: selected ? 240 : 200,
//                           duration: const Duration(seconds: 1),
//                           curve: Curves.decelerate,
//                           decoration: BoxDecoration(
//                             color: selected
//                                 ? AppColor.primaryColor.withOpacity(0.11)
//                                 : AppColor.primaryColor.withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(200),
//                           ),
//                         ),
//                         Positioned(
//                           left: 25,
//                           top: 13,
//                           child: AnimatedContainer(
//                             margin: const EdgeInsets.only(top: 10),
//                             decoration: BoxDecoration(
//                               color: selected
//                                   ? AppColor.primaryColor.withOpacity(0.13)
//                                   : AppColor.primaryColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(200),
//                             ),
//                             duration: const Duration(seconds: 1),
//                             curve: Curves.decelerate,
//                             height: selected ? 191 : 150,
//                             width: selected ? 191 : 150,
//                             child: Center(
//                               child: Icon(
//                                 Icons.location_on,
//                                 size: 100,
//                                 color: AppColor.darkerYellow,
//                               ),
//                             ),
//                             onEnd: () {
//                               setState(() {
//                                 selected = !selected;
//                                 bottonComplete = !bottonComplete;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   //
//                   SizedBox(
//                     height: screenSize.height * 0.04,
//                   ),
//                   Text(
//                     'Find friend from the list of\nEmergency contacts',
//                     style: style.copyWith(
//                       color: AppColor.darkerGrey,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   //
//                   SizedBox(
//                     height: screenSize.height * 0.04,
//                   ),

//                   // DropDown contact list
//                   Container(
//                     height: 49,
//                     width: screenSize.width,
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     decoration: BoxDecoration(
//                       color: AppColor.lightGrey,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: DropdownButton<Users>(
//                       underline: const Divider(color: Colors.transparent),
//                       hint: Text(
//                         'Select friends from emergency contact',
//                         style: style.copyWith(
//                             color: const Color(0xff626262), fontSize: 14),
//                       ),
//                       isExpanded: true,
//                       elevation: 16,
//                       style: style.copyWith(fontSize: 14),
//                       onChanged: (newValue) {
//                         setState(() {
//                           _selectedContact = newValue!;
//                           selected = !selected;
//                         });
//                       },
//                       items: users.map<DropdownMenuItem<Users>>((value) {
//                         return DropdownMenuItem<Users>(
//                           value: Users(
//                             id: value.id,
//                             fullName: value.fullName,
//                             phoneNumber: value.phoneNumber,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 value.fullName ?? 'no',
//                                 style: style.copyWith(
//                                   color: AppColor.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               Text(
//                                 value.phoneNumber ?? 'no',
//                                 style: style.copyWith(
//                                   color: AppColor.darkerGrey,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Container(
//                                 height: 1,
//                                 width: screenSize.width,
//                                 margin:
//                                     const EdgeInsets.only(top: 10, bottom: 2),
//                                 color: AppColor.lightGrey,
//                               )
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),

//                   // selected contact
//                   Container(
//                     height: 80,
//                     width: screenSize.width,
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: AppColor.lightOrange,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 41,
//                           width: 41,
//                           decoration: BoxDecoration(
//                             color: AppColor.white,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: const Center(
//                             child: Icon(Icons.person_outline),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(_selectedContact.fullName ?? ''),
//                             Text(_selectedContact.phoneNumber ?? ''),
//                           ],
//                         ),
//                         Expanded(child: Container()),
//                         const Icon(Icons.check, color: Colors.green),
//                       ],
//                     ),
//                   ),

//                   // Find a friend buton
//                   SizedBox(
//                     height: screenSize.height * 0.05,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: MainButton(
//                       borderColor: Colors.transparent,
//                       child: Text(
//                         'FIND FRIEND',
//                         style: style.copyWith(
//                           fontSize: 14,
//                           color: AppColor.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       backgroundColor: AppColor.primaryColor,
//                       onTap: () {
//                         if (provider.locationPosition == null) {
//                           provider.checkGps(context);
//                         } else {
//                           pushNewScreen(
//                             context,
//                             screen: MapScreen(destination: users[2]),
//                             withNavBar: false,
//                             pageTransitionAnimation:
//                                 PageTransitionAnimation.cupertino,
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
