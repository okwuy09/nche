import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/feedcard.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';

class SaveFeed extends StatefulWidget {
  const SaveFeed({Key? key}) : super(key: key);

  @override
  State<SaveFeed> createState() => _SaveFeedState();
}

class _SaveFeedState extends State<SaveFeed> {
  //late VideoPlayerController _controller;

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
                            borderRadius:
                                BorderRadius.circular(screenSize.height * 0.3),
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
                        padding: const EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: post.length,
                        itemBuilder: (context, index) {
                          return FeedCard(
                            context: context,
                            index: index,
                            post: post,
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
          },
        ),
      ),
    );
  }
}
