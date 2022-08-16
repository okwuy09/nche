import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/chatuser.dart';
import 'package:nche/ui/direct_message/conversationList.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({Key? key}) : super(key: key);

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  final TextEditingController _search = TextEditingController();

  List<ChatAgency> chatAgency = [
    ChatAgency(
      name: "Nigeria Police",
      messageText: "Awesome Setup",
      avarter: "assets/police_logo.png",
      time: DateTime.now(),
    ),
    ChatAgency(
      name: "Nigeria Army",
      messageText: "That's Great",
      avarter: "assets/nigeria_army.png",
      time: DateTime.now(),
    ),
    ChatAgency(
      name: "Nigeria Fire Service",
      messageText: "Hey where are you?",
      avarter: "assets/nigeria_fireservice.jpg",
      time: DateTime.now(),
    ),
    ChatAgency(
      name: "Nigeria EFCC",
      messageText: "Busy! Call me in 20 mins",
      avarter: "assets/nigeria_efcc.jpeg",
      time: DateTime.now(),
    ),

    //
    // ChatAgency(
    //     name: "Debra Hawkins",
    //     messageText: "Thankyou, It's awesome",
    //     imageURL: "assets/arm.png",
    //     time: "23 Mar"),
    // ChatAgency(
    //     name: "Jacob Pena",
    //     messageText: "will update you in evening",
    //     imageURL: "assets/musk.jpg",
    //     time: "17 Mar"),
    // ChatAgency(
    //     name: "Andrey Jones",
    //     messageText: "Can you please share the file?",
    //     imageURL: "assets/accident.jpg",
    //     time: "24 Feb"),
    // ChatAgency(
    //     name: "John Wick",
    //     messageText: "How are you?",
    //     imageURL: "assets/arm.png",
    //     time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Direct Messages',
                      //"Conversations",
                      style: style.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.darkerYellow,
                      ),
                      child: Center(
                        child: Text(
                          "Agency Support",
                          style: style.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // the search box
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: AppColor.darkerGrey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.darkerGrey,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),

            // list of messages
            ListView.builder(
              itemCount: chatAgency.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (_search.text == '') {
                  return ConversationList(
                    name: chatAgency[index].name,
                    messageText: chatAgency[index].messageText,
                    imageUrl: chatAgency[index].avarter,
                    time: chatAgency[index].time.toIso8601String(),
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                }
                if (_search.text != '' &&
                    chatAgency[index].name.toLowerCase().contains(
                          _search.text.toLowerCase(),
                        )) {
                  return ConversationList(
                    name: chatAgency[index].name,
                    messageText: chatAgency[index].messageText,
                    imageUrl: chatAgency[index].avarter,
                    time: chatAgency[index].time.toIso8601String(),
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   backgroundColor: AppColor.white,
    //   appBar: AppBar(
    //     backgroundColor: AppColor.white,
    //     elevation: 0,
    //     toolbarHeight: 60,
    //     iconTheme: IconThemeData(color: AppColor.black),
    //     title: Text(
    //       'Direct Message',
    //       style: style.copyWith(
    //         fontSize: 18,
    //         fontWeight: FontWeight.w500,
    //       ),
    //     ),
    //   ),
    //   body: Column(
    //     children: [
    //       SizedBox(
    //         height: screenSize.height * 0.22,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             const SizedBox(height: 2),
    //             Container(
    //               height: 55,
    //               width: 55,
    //               decoration: BoxDecoration(
    //                 color: AppColor.lighterOrange,
    //                 borderRadius: BorderRadius.circular(100),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   'P',
    //                   style: style.copyWith(
    //                     fontSize: 30,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 5),

    //             // Agent name
    //             Text(
    //               'Nigerian Police Force',
    //               style: style.copyWith(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),

    //             // Agent location
    //             Text(
    //               'Enugu, Nigeria',
    //               style: style.copyWith(
    //                 fontSize: 12,
    //                 color: AppColor.darkerGrey,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),

    //             // view agent profile image button
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                 horizontal: 100,
    //                 vertical: 9,
    //               ),
    //               child: MainButton(
    //                 borderColor: Colors.transparent,
    //                 text: 'View Profile',
    //                 backgroundColor: AppColor.darkerYellow,
    //                 onTap: () {},
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Divider(
    //         height: 5,
    //         color: AppColor.grey,
    //       ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: 3,
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.symmetric(
    //                 horizontal: 20,
    //                 vertical: 10,
    //               ),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     'Today',
    //                     style: style.copyWith(color: AppColor.blue),
    //                   ),

    //                   // receiver messages
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Container(
    //                             height: 36,
    //                             width: 36,
    //                             decoration: BoxDecoration(
    //                               color: AppColor.lightOrange,
    //                               borderRadius: BorderRadius.circular(100),
    //                             ),
    //                             child: Center(
    //                               child: Text(
    //                                 'P',
    //                                 style: style.copyWith(
    //                                   fontSize: 20,
    //                                   fontWeight: FontWeight.w500,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(width: 15),
    //                           Text(
    //                             'Nigerian Police Force',
    //                             style: style.copyWith(fontSize: 14),
    //                           ),
    //                           const SizedBox(width: 10),
    //                           Icon(
    //                             Icons.circle_sharp,
    //                             size: 6,
    //                             color: AppColor.grey,
    //                           ),

    //                           // message time
    //                           const SizedBox(width: 5),
    //                           Text(
    //                             '8 mins ago',
    //                             style: style.copyWith(
    //                               fontSize: 12,
    //                               color: AppColor.grey,
    //                             ),
    //                           ),
    //                           //
    //                         ],
    //                       ),
    //                       const SizedBox(width: 20),
    //                       Container(
    //                         width: double.infinity,
    //                         padding: const EdgeInsets.all(8),
    //                         margin: const EdgeInsets.only(left: 40, right: 10),
    //                         decoration: BoxDecoration(
    //                           color: AppColor.lightGrey,
    //                           borderRadius: const BorderRadius.only(
    //                             bottomRight: Radius.circular(20),
    //                             bottomLeft: Radius.circular(20),
    //                             topRight: Radius.circular(20),
    //                           ),
    //                         ),
    //                         child: Center(
    //                           child: Text(
    //                             'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    //                             style: style.copyWith(
    //                               color: AppColor.brown,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),

    //                   // reporter message

    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 10),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             // message time
    //                             const SizedBox(width: 5),
    //                             Text(
    //                               '8 mins ago',
    //                               style: style.copyWith(
    //                                 fontSize: 12,
    //                                 color: AppColor.grey,
    //                               ),
    //                             ),
    //                             const SizedBox(width: 10),
    //                             const Icon(
    //                               Icons.circle_sharp,
    //                               size: 6,
    //                               color: Colors.green,
    //                             ),
    //                             const SizedBox(width: 5),
    //                             Text(
    //                               'You',
    //                               style: style.copyWith(fontSize: 14),
    //                             ),
    //                             const SizedBox(width: 10),

    //                             // profile picture
    //                             Container(
    //                               height: 36,
    //                               width: 36,
    //                               decoration: BoxDecoration(
    //                                 color: AppColor.lightOrange,
    //                                 borderRadius: BorderRadius.circular(100),
    //                                 image: const DecorationImage(
    //                                     image: AssetImage('assets/musk.jpg'),
    //                                     fit: BoxFit.cover),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(width: 20),
    //                         Container(
    //                           width: double.infinity,
    //                           padding: const EdgeInsets.all(8),
    //                           margin:
    //                               const EdgeInsets.only(left: 10, right: 40),
    //                           decoration: BoxDecoration(
    //                             color: AppColor.darkerYellow,
    //                             borderRadius: const BorderRadius.only(
    //                               bottomRight: Radius.circular(20),
    //                               bottomLeft: Radius.circular(20),
    //                               topLeft: Radius.circular(20),
    //                             ),
    //                           ),
    //                           child: Center(
    //                             child: Text(
    //                               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. consectetur adipiscing elit',
    //                               style: style.copyWith(
    //                                 color: AppColor.brown,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //       const SizedBox(height: 50)
    //     ],
    //   ),
    //   bottomSheet: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    //     child: Row(
    //       children: [
    //         // type and send message field
    //         Container(
    //           height: 51,
    //           width: screenSize.width * 0.733,
    //           padding: const EdgeInsets.all(5),
    //           decoration: BoxDecoration(
    //             color: const Color(0xffDCDCDC),
    //             borderRadius: BorderRadius.circular(6),
    //           ),
    //           child: Row(
    //             children: [
    //               // TextFormField(
    //               //   controller: _message,
    //               //   validator: (input) =>
    //               //       (input!.isEmpty) ? "Enter Your Statement" : null,
    //               //   keyboardType: TextInputType.multiline,
    //               //   maxLines: null,
    //               //   decoration: InputDecoration(
    //               //     alignLabelWithHint: true,
    //               //     border: InputBorder.none,
    //               //     hintStyle: style.copyWith(color: AppColor.darkerGrey),
    //               //     hintText: 'Type a message...',
    //               //     contentPadding: const EdgeInsets.symmetric(
    //               //         vertical: 0.0, horizontal: 0),
    //               //   ),
    //               // ),
    //               Expanded(child: Container()),

    //               // attach files
    //               InkWell(
    //                 onTap: () {},
    //                 child: Icon(
    //                   Icons.attach_file_outlined,
    //                   color: AppColor.darkerGrey,
    //                 ),
    //               ),
    //               const SizedBox(width: 8),

    //               // capture image from camera
    //               InkWell(
    //                 onTap: () {},
    //                 child: Icon(
    //                   Icons.camera_alt_outlined,
    //                   color: AppColor.darkerGrey,
    //                 ),
    //               ),
    //               const SizedBox(width: 8),

    //               // audio recording
    //               InkWell(
    //                 onTap: () {},
    //                 child: Icon(
    //                   Icons.mic,
    //                   color: AppColor.darkerGrey,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(width: 5),
    //         Container(
    //           height: 51,
    //           width: 51,
    //           padding: const EdgeInsets.all(5),
    //           decoration: BoxDecoration(
    //             color: AppColor.primaryColor,
    //             borderRadius: BorderRadius.circular(6),
    //           ),
    //           child: IconButton(
    //             onPressed: () {},
    //             icon: const Icon(
    //               Icons.send,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
