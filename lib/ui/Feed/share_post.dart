import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/popover.dart';
import 'package:nche/components/style.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';

class SharePost extends StatelessWidget {
  final UserData provider;
  final FeedPost post;
  final Size screenSize;
  final BuildContext? ctx;
  const SharePost(
      {Key? key,
      required this.ctx,
      required this.post,
      required this.provider,
      required this.screenSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Popover(
      mainAxisSize: MainAxisSize.min,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.lightGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shareList(
              onTap: () async {
                Navigator.pop(context);
                await provider.sharePost(
                    imageUrl: post.avarter![0], text: post.writeUp);
              },
              icon: Icons.share,
              title: 'Share',
            ),
            const Divider(height: 0),
            shareList(
              onTap: () {
                Navigator.pop(context);
              },
              icon: Icons.report_outlined,
              title: 'Report',
            ),
            post.sender.id == provider.userData!.id
                ? Column(
                    children: [
                      const Divider(height: 0),
                      shareList(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        icon: Icons.edit_outlined,
                        title: 'Edit',
                      ),
                      const Divider(height: 0),
                      shareList(
                        onTap: () {
                          Navigator.pop(context);
                          provider.deletePost(post.id, ctx!);
                        },
                        icon: Icons.delete_outline,
                        title: 'Delete',
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  shareList(
      {required Function() onTap,
      required String title,
      required IconData icon}) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 5.0,
      title: Text(
        title,
        style: style,
      ),
      leading: Icon(
        icon,
        color: AppColor.darkerGrey,
      ),
    );
  }
}
