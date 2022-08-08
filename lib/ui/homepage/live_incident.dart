import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:video_player/video_player.dart';

class LiveIncidents extends StatefulWidget {
  const LiveIncidents({Key? key}) : super(key: key);

  @override
  State<LiveIncidents> createState() => _LiveIncidentsState();
}

class _LiveIncidentsState extends State<LiveIncidents> {
  late VideoPlayerController _controller;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        toolbarHeight: 60,
        elevation: 0,
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(130),
                    child: Image.asset(
                      'assets/musk.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(130),
                          child: Image.asset(
                            'assets/No_image.png',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: -1,
                  top: 5,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: AppColor.white,
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
            Expanded(child: Container()),
            Text(
              'Live Incidents',
              style: style.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                //color: AppColor.bl,
              ),
            ),
            Expanded(flex: 2, child: Container()),
            InkWell(
              onTap: () {},
              child: Container(
                width: 100,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColor.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'START LIVE',
                    style: style.copyWith(
                      fontSize: 14,
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Text(
                    'Live Now',
                    style: style.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'VIEW ALL',
                      style: style.copyWith(color: AppColor.blue),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screenSize.width > 600
                  ? screenSize.width * 0.245
                  : screenSize.height * 0.23,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenSize.width > 600
                        ? screenSize.width * 0.2
                        : screenSize.width * 0.35,
                    padding: const EdgeInsets.only(top: 2),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      //border: Border.all(color: AppColor.lightGrey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            // Post video
                            Stack(
                              children: [
                                Container(
                                    height: screenSize.width > 600
                                        ? screenSize.width * 0.16
                                        : screenSize.height * 0.15,
                                    width: screenSize.width > 600
                                        ? screenSize.width * 0.2
                                        : screenSize.width * 0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: VideoPlayer(_controller),
                                    )),
                                Positioned(
                                  top: screenSize.width > 600
                                      ? screenSize.width * 0.05
                                      : screenSize.height * 0.05,
                                  left: screenSize.width > 600
                                      ? screenSize.width * 0.07
                                      : screenSize.width * 0.13,
                                  //right: 0,
                                  //bottom: 0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(
                                        () {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.transparent.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 25,
                                        color: AppColor.darkerYellow,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: -1,
                              left: -1,
                              child: Container(
                                height: 30,
                                //width: 115,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.white,
                                      size: 16,
                                    ),
                                    Text(
                                      '8.2k',
                                      style: style.copyWith(
                                        fontSize: 10,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      height: 20,
                                      width: 48,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.online_prediction,
                                            size: 16,
                                            color: AppColor.white,
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            'Live',
                                            style: style.copyWith(
                                              fontSize: 12,
                                              color: AppColor.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                    image: AssetImage('assets/musk.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //'Albysax',
                                  'Anonymous',
                                  style: style.copyWith(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 25,
                                  child: Text(
                                    'New Haven Enugu, Nigeria state enugu',
                                    style: style.copyWith(
                                      fontSize: 11,
                                      color: AppColor.darkerGrey,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // Recent live boardcast
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Live',
                    style: style.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: screenSize.height * 0.5235,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenSize.width > 600 ? 3 : 2,
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            // Post video
                            Stack(
                              children: [
                                Container(
                                    height: screenSize.width > 600
                                        ? screenSize.width * 0.3
                                        : screenSize.height * 0.19,
                                    width: screenSize.width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: VideoPlayer(_controller),
                                    )),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  //right: 0,
                                  //bottom: 0,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/musk.jpg'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                //'Albysax',
                                                'Anonymous',
                                                style: style.copyWith(
                                                  fontSize: 16,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenSize.width > 600
                                                    ? screenSize.width * 0.18
                                                    : screenSize.width * 0.22,
                                                height: 25,
                                                child: Text(
                                                  'New Haven Enugu, Nigeria state enugu',
                                                  style: style.copyWith(
                                                    fontSize: 11,
                                                    color: AppColor.darkerGrey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: screenSize.width > 600
                                                  ? screenSize.width * 0.02
                                                  : 4),
                                          Icon(
                                            Icons.share,
                                            color: AppColor.white,
                                            size: 20,
                                          )
                                        ],
                                      ),

                                      // play and pause button
                                      SizedBox(
                                        height: screenSize.width > 600
                                            ? screenSize.width * 0.05
                                            : screenSize.height * 0.016,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(
                                            () {
                                              _controller.value.isPlaying
                                                  ? _controller.pause()
                                                  : _controller.play();
                                            },
                                          );
                                        },
                                        child: Container(
                                          height:
                                              screenSize.width > 600 ? 40 : 30,
                                          width:
                                              screenSize.width > 600 ? 40 : 30,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            _controller.value.isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: screenSize.width > 600
                                                ? 30
                                                : 25,
                                            color: AppColor.darkerYellow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 20,
                              right: -1,
                              left: -1,
                              child: Container(
                                height: 30,
                                //width: 115,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '8.2k',
                                      style: style.copyWith(
                                        fontSize: 12,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      '10:32',
                                      style: style.copyWith(
                                        fontSize: 12,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
