import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/date.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/share_post.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';

class PostDetail extends StatefulWidget {
  final int index;
  const PostDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  // late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.black),
        backgroundColor: AppColor.white,
        toolbarHeight: 60,
        elevation: 0,
        title: Row(
          children: [
            Expanded(child: Container()),
            Text(
              'Post Detail',
              style: style.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<FeedPost>>(
          stream: provider.fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var post = snapshot.data![widget.index];
              return Container(
                width: screenSize.width,
                margin: const EdgeInsets.only(
                  bottom: 12,
                  left: 5,
                  right: 5,
                  top: 5,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(4),
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
                            color:
                                Colors.primaries[1 % Colors.primaries.length],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: post.isAnanymous
                                  ? Text(
                                      'Ananymous'[0].toUpperCase(),
                                      style: style.copyWith(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 28,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: AppColor.white,
                                      backgroundImage: NetworkImage(
                                        post.sender.avarter!,
                                      ),
                                    )),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              post.isAnanymous
                                  ? 'Anonymous'
                                  : post.sender.userName!,
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
                          timeEn(post.time.toIso8601String(), numberDate: true),
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

                        post.avarter!.isEmpty
                            ? Container()
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: screenSize.width,
                                  mainAxisExtent: screenSize.height * 0.29,
                                  //crossAxisSpacing: 2,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: post.avarter!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(post.avarter![index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
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
                    const SizedBox(height: 15),
                    SizedBox(
                      child: Text(
                        post.writeUp,
                        style: style,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        //
                        // up like

                        InkWell(
                          onTap: () async {
                            if (post.downLike!.contains(
                              provider.userData!.id,
                            )) {
                              await provider.removeDownLikePost(post.id);
                              await provider.upLikePost(post.id);
                            } else if (post.upLike!.contains(
                              provider.userData!.id,
                            )) {
                              await provider.removeUpLikePost(post.id);
                            } else {
                              await provider.upLikePost(post.id);
                            }
                          },
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: post.upLike!.contains(provider.userData!.id)
                                ? AppColor.darkerYellow
                                : AppColor.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          post.upLike!.length.toString(),
                          style: style.copyWith(fontSize: 10),
                        ),
                        //
                        // down like
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () async {
                            if (post.upLike!.contains(
                              provider.userData!.id,
                            )) {
                              await provider.removeUpLikePost(post.id);
                              await provider.downLikePost(post.id);
                            } else if (post.downLike!.contains(
                              provider.userData!.id,
                            )) {
                              await provider.removeDownLikePost(post.id);
                            } else {
                              await provider.downLikePost(post.id);
                            }
                          },
                          child: Icon(
                            Icons.thumb_down_alt_outlined,
                            color:
                                post.downLike!.contains(provider.userData!.id)
                                    ? AppColor.darkerYellow
                                    : AppColor.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          post.downLike!.length.toString(),
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
                            if (post.savePost!.contains(
                              provider.userData!.id,
                            )) {
                              await provider.removeSavePost(
                                post.id,
                              );
                            } else {
                              await provider.savePost(
                                post.id,
                              );
                            }
                          },
                          child: Icon(
                            Icons.bookmark_outline,
                            color:
                                post.savePost!.contains(provider.userData!.id)
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
                                  ctx: context,
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
            }
            return Center(
              child: Text(
                'LOADING...',
                style: style.copyWith(
                  color: AppColor.grey,
                  fontSize: 12,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
