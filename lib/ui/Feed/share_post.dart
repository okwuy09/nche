import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/popover.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';

class SharePost extends StatelessWidget {
  final UserData provider;
  final List<FeedPost> post;
  final int index;
  final Size screenSize;
  const SharePost(
      {Key? key,
      required this.index,
      required this.post,
      required this.provider,
      required this.screenSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Popover(
      mainAxisSize: MainAxisSize.min,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await provider.sharePost(
                      imageUrl: post[index].avarter!,
                      text: post[index].writeUp);
                },
                child: actionbutton(
                  screenSize: screenSize,
                  icon: provider.isSharing
                      ? buttonCircularIndicator
                      : Icon(
                          Icons.share,
                          color: AppColor.darkerYellow,
                        ),
                  title: 'Share',
                ),
              ),
              SizedBox(width: screenSize.width * 0.1),
              InkWell(
                child: actionbutton(
                  screenSize: screenSize,
                  icon: Icon(
                    Icons.report_outlined,
                    color: AppColor.red,
                  ),
                  title: 'Report',
                ),
              ),
              SizedBox(width: screenSize.width * 0.1),
              InkWell(
                onTap: () {
                  if (post[index].sender.id == provider.userData!.id) {
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: actionbutton(
                  screenSize: screenSize,
                  icon: Icon(
                    post[index].sender.id == provider.userData!.id
                        ? Icons.edit_outlined
                        : Icons.cancel,
                    color: AppColor.brown,
                  ),
                  title: post[index].sender.id == provider.userData!.id
                      ? 'Edit'
                      : 'Cancel',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container actionbutton(
      {required Size screenSize, String? title, required Widget icon}) {
    return Container(
      height: 60,
      width: screenSize.width * 0.2,
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon,
        const SizedBox(height: 2),
        Text(
          title!,
          style: style.copyWith(fontSize: 14),
        ),
      ]),
    );
  }
}
