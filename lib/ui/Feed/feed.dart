import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/Feed/post_detail.dart';
import 'package:nche/ui/Feed/write_post.dart';
import 'package:nche/ui/homepage/direct_message.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late VideoPlayerController _controller;
  int _upcount = 0;
  int _downcount = 0;
  bool _acceptClicks = true;
  bool _upClicks = true;
  bool _downClicks = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://cdn.videvo.net/videvo_files/video/premium/video0049/small_watermarked/900-1_900-2942-PD2_preview.webm')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      floatingActionButton: Stack(
        children: [
          SpeedDial(
            overlayColor: Colors.transparent,
            overlayOpacity: 0,
            backgroundColor: AppColor.darkerYellow,
            child: Icon(
              Icons.add,
              size: 28,
              color: AppColor.black,
            ),
            children: [
              SpeedDialChild(
                child: const Icon(Icons.edit_outlined),
                backgroundColor: AppColor.darkerYellow,
                onTap: () => pushNewScreen(
                  context,
                  screen: const WritePost(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ),
              ),
              SpeedDialChild(
                child: Stack(
                  children: [
                    const Icon(Icons.message_outlined),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            '9',
                            style: style.copyWith(
                              fontSize: 8,
                              color: AppColor.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: AppColor.darkerYellow,
                onTap: () => pushNewScreen(
                  context,
                  screen: const DirectMessage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ),
              ),
            ],
          ),
          //
          Positioned(
            right: 2,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  '9',
                  style: style.copyWith(
                    fontSize: 9,
                    color: AppColor.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: screenSize.width > 600
                              ? screenSize.width * 0.5
                              : screenSize.height * 0.32,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: AppColor.grey,
                            borderRadius: BorderRadius.circular(6),
                            image: const DecorationImage(
                                image: AssetImage('assets/musk.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                height: screenSize.width > 600
                                    ? screenSize.width * 0.2
                                    : screenSize.width * 0.3,
                                width: screenSize.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 22,
                                          color: AppColor.white,
                                          child: Center(
                                            child: Text(
                                              'P',
                                              style: style.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Nigeria Police Force',
                                          style: style.copyWith(
                                              color: AppColor.white),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: screenSize.width,
                                      height: 45,
                                      child: Text(
                                        'The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.',
                                        style: style.copyWith(
                                            color: AppColor.lightGrey,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const PostDetail(),
                                            ),
                                          ),
                                          child: Text(
                                            'READ MORE',
                                            style: style.copyWith(
                                              fontSize: 13,
                                              color: AppColor.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            height: 24.29,
                            width: 70,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColor.white),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list_alt_sharp,
                                  size: 18,
                                  color: AppColor.white,
                                ),
                                //
                                const SizedBox(width: 4),
                                Text(
                                  'New In',
                                  style: style.copyWith(
                                      color: AppColor.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //  list of post feeds
                  const SizedBox(height: 10),
                  Container(
                    width: screenSize.width,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.lightGrey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
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
                                    fontSize: 30,
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
                                  style: style,
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
                                          fontSize: 14, color: AppColor.grey),
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
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            // Post video
                            Stack(
                              children: [
                                Container(
                                    height: screenSize.width > 600
                                        ? screenSize.width * 0.45
                                        : screenSize.height * 0.25,
                                    width: screenSize.width,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: VideoPlayer(_controller),
                                    )),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause_circle_outlined
                                          : Icons.play_circle_outline,
                                      size: 50,
                                      color: AppColor.white,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),

                            // post image

                            // Container(
                            //   height: screenSize.width > 600
                            // ? screenSize.width * 0.45
                            // : screenSize.height * 0.25,
                            //   width: screenSize.width,
                            //   margin: const EdgeInsets.symmetric(vertical: 10),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(6),
                            //     image: const DecorationImage(
                            //       image: AssetImage('assets/accident.jpg'),
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
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
                            'The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.The Nigerian police force advices the Nigeria youths to stay indoors.',
                            style: style,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PostDetail(),
                                ),
                              ),
                              child: Text(
                                'READ MORE',
                                style: style.copyWith(
                                  fontSize: 13,
                                  color: AppColor.darkerGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            // wallet icon
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.wallet_giftcard,
                                color: AppColor.darkerGrey,
                                size: 30,
                              ),
                            ),
                            // save icon

                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.bookmark_outline,
                                color: AppColor.darkerGrey,
                                size: 30,
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
                                color: !_upClicks
                                    ? AppColor.blue
                                    : AppColor.darkerGrey,
                                size: 30,
                              ),
                            ),
                            Text(
                              _upcount.toString(),
                              style: style.copyWith(fontSize: 12),
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
                                size: 30,
                              ),
                            ),
                            Text(
                              _downcount.toString(),
                              style: style.copyWith(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // second list

                  Container(
                    //height: 345,
                    width: screenSize.width,
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.lightGrey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
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
                                    fontSize: 30,
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
                                  style: style,
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
                                          fontSize: 14, color: AppColor.grey),
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
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            // Post video

                            // Stack(
                            //   children: [
                            //     Container(
                            //         height: screenSize.width > 600
                            // ? screenSize.width * 0.45
                            // : screenSize.height * 0.25,
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
                              height: screenSize.width > 600
                                  ? screenSize.width * 0.45
                                  : screenSize.height * 0.25,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PostDetail(),
                                ),
                              ),
                              child: Text(
                                'READ MORE',
                                style: style.copyWith(
                                  fontSize: 13,
                                  color: AppColor.darkerGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            // wallet icon
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.wallet_giftcard,
                                color: AppColor.darkerGrey,
                                size: 30,
                              ),
                            ),
                            // save icon

                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.bookmark_outline,
                                color: AppColor.darkerGrey,
                                size: 30,
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
                                color: !_upClicks
                                    ? AppColor.blue
                                    : AppColor.darkerGrey,
                                size: 30,
                              ),
                            ),
                            Text(
                              _upcount.toString(),
                              style: style.copyWith(fontSize: 12),
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
                                size: 30,
                              ),
                            ),
                            Text(
                              _downcount.toString(),
                              style: style.copyWith(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
