import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/date.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/post_detail.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SaveFeed extends StatefulWidget {
  const SaveFeed({Key? key}) : super(key: key);

  @override
  State<SaveFeed> createState() => _SaveFeedState();
}

class _SaveFeedState extends State<SaveFeed> {
  late VideoPlayerController _controller;

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
      body: SingleChildScrollView(
        child: StreamBuilder<List<FeedPost>>(
            stream: provider.fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var posts = snapshot.data!;
                var post = posts
                    .where((e) => e.savePost!.contains(provider.userData!.id))
                    .toList();

                return post.isEmpty
                    ? SizedBox(
                        height: screenSize.height * 0.7,
                        child: Center(
                          child: Container(
                            height: screenSize.height * 0.3,
                            width: screenSize.height * 0.3,
                            decoration: BoxDecoration(
                              color: AppColor.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                  screenSize.height * 0.3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_empty_outlined,
                                  size: screenSize.height * 0.12,
                                  color: AppColor.grey,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'No Saved Post',
                                  style: style.copyWith(
                                    fontSize: 20,
                                    color: AppColor.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            return Container(
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
                                          color: Colors.primaries[
                                              index % Colors.primaries.length],
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
                                                : post[index].sender.userName!,
                                            style: style.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '*Accident',
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
                                            post[index].time.toIso8601String(),
                                            numberDate: true),

                                        //'Sept 27, 2022',
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
                                          color: AppColor.grey,
                                        ),
                                      ),
                                      // save icon

                                      const SizedBox(width: 30),
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
                                          color: post[index].savePost!.contains(
                                                  provider.userData!.id)
                                              ? AppColor.darkerYellow
                                              : AppColor.grey,
                                        ),
                                      ),

                                      // up like
                                      Flexible(child: Container()),
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
                                        style: style.copyWith(fontSize: 12),
                                      ),

                                      // down like
                                      const SizedBox(width: 30),
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
                                          color: post[index].downLike!.contains(
                                                  provider.userData!.id)
                                              ? AppColor.darkerYellow
                                              : AppColor.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        post[index].downLike!.length.toString(),
                                        style: style.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    'LOADING...',
                    style: style.copyWith(
                      color: AppColor.grey,
                      fontSize: 12,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
