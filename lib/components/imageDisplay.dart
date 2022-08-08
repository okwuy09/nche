// import 'package:flutter/material.dart';

// Widget fileBuilder({
//   String? imgPath,
//   Map<String, String>? imgPaths,
//   bool isLoadingPath = false,
// }) {
//   return Builder(
//     builder: (BuildContext context) => isLoadingPath
//         ? const Padding(padding: const EdgeInsets.only(bottom: 4.0))
//         : imgPath != null ||
//                 imgPaths != null && (imgPaths.length > 1 && imgPaths.length < 5)
//             ? SizedBox(
//                 height: imgPaths!.length > 1
//                     ? MediaQuery.of(context).size.height * 0.15
//                     : MediaQuery.of(context).size.height * 0.10,
//                 width: MediaQuery.of(context).size.width,
//                 child: Scrollbar(
//                     child: ListView.separated(
//                   itemCount: imgPaths != null && imgPaths.isNotEmpty
//                       ? imgPaths.length
//                       : 1,
//                   itemBuilder: (BuildContext context, int index) {
//                     final bool isMultiPath =
//                         imgPaths != null && imgPaths.isNotEmpty;
//                     final int fileNo = index + 1;
//                     final String name = 'File $fileNo : ' +
//                         (isMultiPath
//                             ? imgPaths.keys.toList()[index]
//                             : imgPath ?? '...');
//                     final filePath = isMultiPath
//                         ? imgPaths.values.toList()[index].toString()
//                         : imgPath;
//                     return ListTile(
//                       title: Transform.translate(
//                         offset: const Offset(-25, 0),
//                         child: Text(
//                           name,
//                         ),
//                       ),
//                       leading: const Icon(
//                         Icons.attach_file_outlined,
//                         color: Color(0xFFF3A494),
//                       ),
//                       dense: true,
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) =>
//                       const Divider(),
//                 )),
//               )
//             : Text('4 photos is the maximum'),
//   );
// }
