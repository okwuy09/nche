import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/date.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/chat_message.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _newMessage = TextEditingController();

  List<ChatMessage> messages = [
    ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      time: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
      time: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender",
      time: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "ehhhh, doing OK. Hey Kriss, ",
      messageType: "receiver",
      time: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
      time: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/police_logo.png"),
                        maxRadius: 30,
                      ),
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Nigeria Police",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Online",
                            style: style.copyWith(
                              color: AppColor.darkerGrey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 35)
                // const Icon(
                //   Icons.settings,
                //   color: Colors.black54,
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 60),
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 5,
                  bottom: 5,
                ),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : AppColor.darkerYellow),
                    ),
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
                    margin: EdgeInsets.only(
                      left: messages[index].messageType == "receiver" ? 0 : 40,
                      right: messages[index].messageType == "receiver" ? 40 : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          messages[index].messageContent,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          timeEn(messages[index].time.toString()),
                          //'${messages[index].time.minute} AM',
                          style: style.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkerGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // display image in the chat

                  //  Container(
                  //     padding: const EdgeInsets.all(3),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: (messages[index].messageType == "receiver"
                  //           ? Colors.grey.shade200
                  //           : AppColor.darkerYellow),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Container(
                  //           height: 150,
                  //           width: 150,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color:
                  //                 (messages[index].messageType == "receiver"
                  //                     ? Colors.grey.shade200
                  //                     : AppColor.darkerYellow),
                  //             image: const DecorationImage(
                  //                 image: AssetImage('assets/musk.jpg'),
                  //                 fit: BoxFit.cover),
                  //           ),
                  //         ),
                  //         const SizedBox(height: 2),
                  //         Text(
                  //           '11: 30 AM',
                  //           style: style.copyWith(
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w500,
                  //             color: AppColor.darkerGrey,
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColor.lightGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _newMessage,
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle:
                                      TextStyle(color: AppColor.darkerGrey),
                                  border: InputBorder.none),
                            ),
                          ),
                          //attach files
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.attach_file_sharp,
                              color: AppColor.darkerGrey,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 15),

                          // capture image from camera
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: AppColor.darkerGrey,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        messages.add(
                          ChatMessage(
                            messageContent: _newMessage.text,
                            messageType: "sender",
                            time: DateTime.now(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColor.darkerYellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.send,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
