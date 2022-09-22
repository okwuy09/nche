import 'package:nche/components/colors.dart';
import 'package:nche/components/date.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/grid_image.dart';
import 'package:nche/ui/Feed/post_detail.dart';
import 'package:nche/ui/Feed/share_post.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final int index;
  final List<FeedPost> post;
  final BuildContext context;
  const FeedCard({
    Key? key,
    required this.context,
    required this.index,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserData>(context);
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  color: Colors.primaries[index % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: post[index].isAnanymous
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
                            post[index].sender.avarter!,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
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
                    post[index].incidentType!,
                    style: style.copyWith(
                      fontSize: 10,
                      color: AppColor.darkerGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text(
                timeEn(post[index].time.toIso8601String(), numberDate: true),
                style: style.copyWith(
                  color: AppColor.darkerGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetail(index: index),
              ),
            ),
            child: Stack(
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

                post[index].avarter!.isEmpty
                    ? Container()
                    : Container(
                        height: screenSize.width > 600
                            ? screenSize.width * 0.45
                            : screenSize.height * 0.29,
                        width: screenSize.width,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: post[index].avarter!.length <= 1
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(post[index].avarter![0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : PhotoGrid(
                                imageUrls: post[index].avarter!,
                                onImageClicked: (i) {},
                                onExpandClicked: () {},
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
                              '${post[index].location!} State',
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
          ),
          SizedBox(
            child: Text(
              post[index].writeUp.length > 250
                  ? '${post[index].writeUp.substring(0, 250)}...'
                  : post[index].writeUp,
              style: style.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.black.withOpacity(0.6),
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetail(index: index),
                  ),
                ),
                child: Text(
                  'READ MORE',
                  style: style.copyWith(
                    fontSize: 13,
                    color: AppColor.brown.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          Row(
            children: [
              //
              // up like

              InkWell(
                onTap: () async {
                  if (post[index].downLike!.contains(
                        provider.userData.id,
                      )) {
                    await provider.removeDownLikePost(post[index].id);
                    await provider.upLikePost(post[index].id);
                  } else if (post[index].upLike!.contains(
                        provider.userData.id,
                      )) {
                    await provider.removeUpLikePost(post[index].id);
                  } else {
                    await provider.upLikePost(post[index].id);
                  }
                },
                child: Icon(
                  Icons.thumb_up_alt_outlined,
                  color: post[index].upLike!.contains(provider.userData.id)
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
                        provider.userData.id,
                      )) {
                    await provider.removeUpLikePost(post[index].id);
                    await provider.downLikePost(post[index].id);
                  } else if (post[index].downLike!.contains(
                        provider.userData.id,
                      )) {
                    await provider.removeDownLikePost(post[index].id);
                  } else {
                    await provider.downLikePost(post[index].id);
                  }
                },
                child: Icon(
                  Icons.thumb_down_alt_outlined,
                  color: post[index].downLike!.contains(provider.userData.id)
                      ? AppColor.darkerYellow
                      : AppColor.grey,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                post[index].downLike!.length.toString(),
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
                        provider.userData.id,
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
                  color: post[index].savePost!.contains(provider.userData.id)
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
                        post: post[index],
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
}
