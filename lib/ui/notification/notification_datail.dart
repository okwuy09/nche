import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
//import 'package:video_player/video_player.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails({Key? key}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  //late VideoPlayerController _controller;
  int _upcount = 0;
  int _downcount = 0;
  bool _upClicks = true;
  bool _downClicks = true;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.brown,
        toolbarHeight: 60,
        elevation: 0,
        title: Row(
          children: [
            Expanded(child: Container()),
            Text(
              'Notification Detail',
              style: style.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColor.white,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, int index) {
            return Container(
              //height: screenSize.width * 1.1,
              width: screenSize.width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColor.orange,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'O',
                            style: style.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Okoli Jeffery',
                            style: style.copyWith(fontSize: 14),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColor.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Accident',
                                style: style.copyWith(
                                    fontSize: 12, color: AppColor.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Text(
                        'Sept 27, 2022',
                        style: style.copyWith(
                          color: const Color(0xff1A1A1A),
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      // Post video

                      // Stack(
                      //   children: [
                      //     Container(
                      //         height: 145,
                      //         width: screenSize.width,
                      //         margin: const EdgeInsets.symmetric(vertical: 10),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(6),
                      //         ),
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(6),
                      //           child: VideoPlayer(_controller),
                      //         )),
                      //     Positioned(
                      //       top: 0,
                      //       left: 0,
                      //       right: 0,
                      //       bottom: 0,
                      //       child: IconButton(
                      //         icon: Icon(
                      //           _controller.value.isPlaying
                      //               ? Icons.pause_circle_outlined
                      //               : Icons.play_circle_outline,
                      //           size: 50,
                      //           color: AppColor.white,
                      //         ),
                      //         onPressed: () {
                      //           setState(
                      //             () {
                      //               _controller.value.isPlaying
                      //                   ? _controller.pause()
                      //                   : _controller.play();
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     )
                      //   ],
                      // ),

                      // post image

                      Container(
                        height: 180,
                        width: screenSize.width,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: const DecorationImage(
                            image: AssetImage('assets/accident.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                          height: 30,
                          width: 145,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.my_location_sharp,
                                  color: AppColor.white,
                                  size: 15,
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    'No1 Nkpokiti street newlayout Enugu state',
                                    style: style.copyWith(
                                      fontSize: 8,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Text(
                      'The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.',
                      style: style,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Row(
                    children: [
                      // wallet icon
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.wallet_giftcard,
                          color: AppColor.darkerGrey,
                        ),
                      ),
                      // save icon

                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.bookmark_outline,
                          color: AppColor.darkerGrey,
                        ),
                      ),

                      // up like
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          if (_upClicks) {
                            setState(() {
                              _upcount++;
                              _upClicks = false;
                            });
                          } else {
                            setState(() {
                              _upcount--;
                              _upClicks = true;
                            });
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_up_sharp,
                          color:
                              !_upClicks ? AppColor.blue : AppColor.darkerGrey,
                        ),
                      ),
                      Text(
                        _upcount.toString(),
                        style: style.copyWith(fontSize: 10),
                      ),

                      // down like
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (_downClicks) {
                            setState(() {
                              _downcount++;
                              _downClicks = false;
                            });
                          } else {
                            setState(() {
                              _downcount--;
                              _downClicks = true;
                            });
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_down_sharp,
                          color: !_downClicks
                              ? AppColor.blue
                              : AppColor.darkerGrey,
                        ),
                      ),
                      Text(
                        _downcount.toString(),
                        style: style.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
