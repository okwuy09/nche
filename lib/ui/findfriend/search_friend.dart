// import 'package:flutter/material.dart';
// import 'package:nche/components/colors.dart';
// import 'package:nche/components/const_values.dart';
// import 'package:nche/model/users.dart';
// import 'package:nche/services/provider/userdata.dart';
// import 'package:nche/ui/findfriend/user_list.dart';
// import 'package:provider/provider.dart';

// class SearchFriends extends SearchDelegate {
//   // appbar color
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return theme.copyWith(
//       textSelectionTheme: TextSelectionThemeData(
//         cursorColor: AppColor.black,
//         selectionColor: AppColor.darkerYellow,
//       ),
//       hintColor: AppColor.darkerGrey,
//       inputDecorationTheme: InputDecorationTheme(
//         border: InputBorder.none,
//         hintStyle: style.copyWith(color: AppColor.grey),
//       ),
//       textTheme: TextTheme(headline6: style),
//     );
//   }

//   // first overwrite to clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: Icon(
//           Icons.clear_rounded,
//           color: AppColor.darkerGrey,
//         ),
//       ),
//     ];
//   }

//   // second overwrite to pop out of search menu
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(
//         Icons.arrow_back,
//         color: AppColor.black,
//       ),
//     );
//   }

//   // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     var provider = Provider.of<UserData>(context);

//     return Container(
//       color: AppColor.white,
//       child: StreamBuilder<List<Users>>(
//         stream: provider.fetchUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var users = snapshot.data!;

//             var user = users
//                 .where((e) =>
//                     e.fullName!.toLowerCase().contains(query.toLowerCase()))
//                 .toList();

//             return MediaQuery.removePadding(
//               removeTop: true,
//               context: context,
//               child: ListView.builder(
//                 padding: const EdgeInsets.only(top: 5),
//                 shrinkWrap: true,
//                 itemCount: user.length,
//                 itemBuilder: (context, index) {
//                   return UsersList(
//                     context: context,
//                     index: index,
//                     users: user,
//                   );
//                 },
//               ),
//             );
//           } else {
//             return Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'LOADING...',
//                 style: style.copyWith(
//                   color: AppColor.grey,
//                   fontSize: 12,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   // last overwrite to show the
//   // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var provider = Provider.of<UserData>(context);

//     return Container(
//       color: AppColor.white,
//       child: StreamBuilder<List<Users>>(
//         stream: provider.fetchUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var users = snapshot.data!;

//             var user = users
//                 .where((e) =>
//                     e.fullName!.toLowerCase().contains(query.toLowerCase()))
//                 .toList();

//             return MediaQuery.removePadding(
//               removeTop: true,
//               context: context,
//               child: ListView.builder(
//                 padding: const EdgeInsets.only(top: 5),
//                 shrinkWrap: true,
//                 itemCount: user.length,
//                 itemBuilder: (context, index) {
//                   return UsersList(
//                     context: context,
//                     index: index,
//                     users: user,
//                   );
//                 },
//               ),
//             );
//           } else {
//             return Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'LOADING...',
//                 style: style.copyWith(
//                   color: AppColor.grey,
//                   fontSize: 12,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
