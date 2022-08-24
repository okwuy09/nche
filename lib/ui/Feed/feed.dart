import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/date.dart';
import 'package:nche/components/popover.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/post_detail.dart';
import 'package:nche/ui/Feed/share_post.dart';
import 'package:nche/ui/Feed/write_post.dart';
import 'package:nche/ui/homepage/direct_message.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late VideoPlayerController _controller;
  // int _upcount = 0;
  // int _downcount = 0;
  // bool _acceptClicks = true;
  // bool _upClicks = false;
  // bool _downClicks = true;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://cdn.videvo.net/videvo_files/video/premium/video0049/small_watermarked/900-1_900-2942-PD2_preview.webm')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
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
      body: SingleChildScrollView(
        child: StreamBuilder<List<FeedPost>>(
          stream: provider.fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var post = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 12,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: screenSize.width > 600
                              ? screenSize.width * 0.5
                              : screenSize.height * 0.34,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                                image: NetworkImage(post[0].avarter ??
                                    'https://firebasestorage.googleapis.com/v0/b/nche-application.appspot.com/o/avatar.png?alt=media&token=f70e3f9c-d432-4a03-b047-4ff97a245b52'),
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
                                    : screenSize.width * 0.35,
                                width: screenSize.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.2),
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
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: post[0].isAnanymous
                                                ? Text(
                                                    'Ananymous'[0]
                                                        .toUpperCase(),
                                                    style: style.copyWith(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        AppColor.white,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      post[0].sender.avarter!,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post[0].isAnanymous
                                                  ? 'Anonymous'
                                                  : post[0].sender.userName!,
                                              //'Nigeria Police Force',
                                              style: style.copyWith(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '*Accident',
                                              style: style.copyWith(
                                                fontSize: 10,
                                                color: AppColor.lightGrey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: screenSize.width,
                                      height: 45,
                                      child: Text(
                                        post[0].writeUp,
                                        //'The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.',
                                        style: style.copyWith(
                                            color: AppColor.lightGrey,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
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
                                              color: AppColor.lightGrey,
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
                  // list of other post
                  MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: post.length,
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Container()
                            : Container(
                                width: screenSize.width,
                                margin: const EdgeInsets.only(
                                    bottom: 12, left: 5, right: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.primaries[index %
                                                Colors.primaries.length],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                              child: post[index].isAnanymous
                                                  ? Text(
                                                      'Ananymous'[0]
                                                          .toUpperCase(),
                                                      style: style.copyWith(
                                                        color: AppColor.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 28,
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          AppColor.white,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        post[index]
                                                            .sender
                                                            .avarter!,
                                                      ),
                                                    )),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              post[index].isAnanymous
                                                  ? 'Anonymous'
                                                  : post[index]
                                                      .sender
                                                      .userName!,
                                              style: style.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Accident',
                                              style: style.copyWith(
                                                fontSize: 10,
                                                color: AppColor.darkerGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          timeEn(
                                              post[index]
                                                  .time
                                                  .toIso8601String(),
                                              numberDate: true),
                                          style: style.copyWith(
                                              color: AppColor.darkerGrey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
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
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: DecorationImage(
                                              image: NetworkImage(post[index]
                                                      .avarter ??
                                                  'https://firebasestorage.googleapis.com/v0/b/nche-application.appspot.com/o/avatar.png?alt=media&token=f70e3f9c-d432-4a03-b047-4ff97a245b52'),
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
                                              color: Colors.transparent
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        post[index].writeUp,
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
                                              builder: (_) =>
                                                  const PostDetail(),
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
                                        //
                                        // up like

                                        InkWell(
                                          onTap: () async {
                                            if (post[index].downLike!.contains(
                                                  provider.userData!.id,
                                                )) {
                                              await provider.removeDownLikePost(
                                                  post[index].id);
                                              await provider
                                                  .upLikePost(post[index].id);
                                            } else if (post[index]
                                                .upLike!
                                                .contains(
                                                  provider.userData!.id,
                                                )) {
                                              await provider.removeUpLikePost(
                                                  post[index].id);
                                            } else {
                                              await provider
                                                  .upLikePost(post[index].id);
                                            }
                                          },
                                          child: Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: post[index].upLike!.contains(
                                                    provider.userData!.id)
                                                ? AppColor.darkerYellow
                                                : AppColor.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          post[index].upLike!.length.toString(),
                                          style: style.copyWith(fontSize: 10),
                                        ),
                                        //
                                        // down like
                                        const SizedBox(width: 20),
                                        InkWell(
                                          onTap: () async {
                                            if (post[index].upLike!.contains(
                                                  provider.userData!.id,
                                                )) {
                                              await provider.removeUpLikePost(
                                                  post[index].id);
                                              await provider
                                                  .downLikePost(post[index].id);
                                            } else if (post[index]
                                                .downLike!
                                                .contains(
                                                  provider.userData!.id,
                                                )) {
                                              await provider.removeDownLikePost(
                                                  post[index].id);
                                            } else {
                                              await provider
                                                  .downLikePost(post[index].id);
                                            }
                                          },
                                          child: Icon(
                                            Icons.thumb_down_alt_outlined,
                                            color: post[index]
                                                    .downLike!
                                                    .contains(
                                                        provider.userData!.id)
                                                ? AppColor.darkerYellow
                                                : AppColor.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          post[index]
                                              .downLike!
                                              .length
                                              .toString(),
                                          style: style.copyWith(fontSize: 10),
                                        ),
                                        // wallet icon
                                        Flexible(child: Container()),
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.wallet_giftcard,
                                            color: AppColor.grey,
                                          ),
                                        ),
                                        //
                                        // save Post icon

                                        const SizedBox(width: 20),
                                        InkWell(
                                          onTap: () async {
                                            if (post[index].savePost!.contains(
                                                  provider.userData!.id,
                                                )) {
                                              await provider.removeSavePost(
                                                post[index].id,
                                              );
                                            } else {
                                              await provider.savePost(
                                                post[index].id,
                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.bookmark_outline,
                                            color: post[index]
                                                    .savePost!
                                                    .contains(
                                                        provider.userData!.id)
                                                ? AppColor.darkerYellow
                                                : AppColor.grey,
                                          ),
                                        ),
                                        //
                                        // share post
                                        const SizedBox(width: 20),
                                        InkWell(
                                          onTap: () {
                                            // handle more vert buttom sheet
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (_) {
                                                return SharePost(
                                                  index: index,
                                                  post: post,
                                                  provider: provider,
                                                  screenSize: screenSize,
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.more_vert,
                                            color: AppColor.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'LOADING...',
                  style: style.copyWith(
                    color: AppColor.grey,
                    fontSize: 12,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
