import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/ui/notification/notification_datail.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColor.black),
        title: Text("Notification",
            style: style.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "Filter",
                style: style.copyWith(
                  color: AppColor.darkerYellow,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //today
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: const [
                  Text(
                    "Today",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            messageList(),
            acceptlist(),
            messageList(),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(
                thickness: 0.1,
                height: 0.1,
                color: Colors.grey,
              ),
            ),

            //yesterday
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    "Yesterday",
                    style: style.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            messageList(),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(
                thickness: 0.1,
                height: 0.1,
                color: Colors.grey,
              ),
            ),

            //this week
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    "this Week",
                    style: style.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            messageList(),
            messageList(),
            acceptlist(),
            messageList(),
            messageList(),
            acceptlist(),
          ],
        ),
      ),
    );
  }

// Notification message list
  messageList() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NotificationDetails(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      width: 40,
                      height: 40,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/musk.jpg'),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nigeria Police ",
                                style: style.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "write a new post. ",
                                style: style.copyWith(
                                  fontSize: 13.0,
                                ),
                              ),
                              Text(
                                "1h ",
                                style: style.copyWith(
                                  color: AppColor.darkerGrey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                    child: SizedBox(
                      width: 30,
                      height: 40,
                      child: Image.asset(
                        'assets/accident.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding acceptlist() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    width: 40,
                    height: 40,
                    child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/musk.jpg'))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                  children: [
                                    TextSpan(
                                      text: "Uche",
                                      style: style.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                            " , Want to add you to his emergency contact."),
                                    TextSpan(
                                      text: " 1h",
                                      style: style.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.darkerGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    width: 70,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(AppColor.black),
                      ),
                      onPressed: () {},
                      child: const Text('Accept'),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
