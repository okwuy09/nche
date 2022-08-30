import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/Feed/post_detail.dart';
import 'package:nche/ui/Feed/write_post.dart';
import 'package:nche/widget/feedcard.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  //late VideoPlayerController _controller;

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.darkerYellow,
        elevation: 3,
        child: Icon(
          Icons.post_add_rounded,
          color: AppColor.brown,
          size: 28,
        ),
        onPressed: () => pushNewScreen(
          context,
          screen: const WritePost(),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<FeedPost>>(
          stream: provider.fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var post = snapshot.data!;
              return Column(
                children: [
                  // latest post in the list of post
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
                              : screenSize.height * 0.4,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: AppColor.lightGrey,
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: post[0].avarter!.isEmpty
                                    ? const AssetImage('assets/avatar.png')
                                        as ImageProvider
                                    : NetworkImage(post[0].avarter![0]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                height: screenSize.width > 600
                                    ? screenSize.height * 0.25
                                    : screenSize.height * 0.2,
                                width: screenSize.width,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
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
                                              'Accident',
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
                                    Text(
                                      post[0].writeUp.length > 180
                                          ? '${post[0].writeUp.substring(0, 180)}...'
                                          : post[0].writeUp,
                                      //'The Nigerian police force advices the Nigeria youths to stay indoors tomorrow to avoid clash with IPOB.',
                                      style: style.copyWith(
                                          color: AppColor.lightGrey,
                                          fontSize: 14),
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
                                                  const PostDetail(index: 0),
                                            ),
                                          ),
                                          child: Text(
                                            '>>  READ MORE',
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
                              borderRadius: BorderRadius.circular(4),
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
                            : FeedCard(
                                context: context,
                                index: index,
                                post: post,
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
