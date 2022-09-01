import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/feed_post.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/widget/feedcard.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  // appbar color
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColor.black,
        selectionColor: AppColor.darkerYellow,
      ),
      hintColor: AppColor.darkerGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: style.copyWith(color: AppColor.grey),
      ),
      textTheme: TextTheme(headline6: style),
    );
  }

  // first overwrite to clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear_rounded,
          color: AppColor.darkerGrey,
        ),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: AppColor.black,
      ),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    var provider = Provider.of<UserData>(context);

    return Container(
      color: AppColor.lightGrey,
      child: StreamBuilder<List<FeedPost>>(
        stream: provider.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var posts = snapshot.data!;

            var post = posts
                .where((e) =>
                    e.writeUp.toLowerCase().contains(query.toLowerCase()))
                .toList();

            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                shrinkWrap: true,
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
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    var provider = Provider.of<UserData>(context);

    return Container(
      color: AppColor.lightGrey,
      child: StreamBuilder<List<FeedPost>>(
        stream: provider.fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var posts = snapshot.data!;

            var post = posts
                .where((e) =>
                    e.writeUp.toLowerCase().contains(query.toLowerCase()))
                .toList();

            return MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                shrinkWrap: true,
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
    );
  }
}
