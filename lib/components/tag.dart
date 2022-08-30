import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';

typedef DeleteTag<T> = void Function(T index);

typedef TagTitle<String> = Widget Function(String tag);

class FlutterTagView extends StatefulWidget {
  FlutterTagView(
      {Key? key,
      required this.tags,
      this.minTagViewHeight = 0,
      this.maxTagViewHeight = 150,
      this.tagBackgroundColor = Colors.black12,
      this.selectedTagBackgroundColor = Colors.lightBlue,
      this.deletableTag = true,
      this.onDeleteTag,
      this.tagTitle})
      : assert(
            tags != null,
            'Tags can\'t be empty\n'
            'Provide the list of tags'),
        super(key: key);

  List<String> tags;

  Color tagBackgroundColor;

  Color selectedTagBackgroundColor;

  bool deletableTag;

  double maxTagViewHeight;

  double minTagViewHeight;

  DeleteTag<int>? onDeleteTag;

  TagTitle<String>? tagTitle;

  @override
  _FlutterTagViewState createState() => _FlutterTagViewState();
}

class _FlutterTagViewState extends State<FlutterTagView> {
  int selectedTagIndex = -1;

  @override
  Widget build(BuildContext context) {
    return getTagView();
  }

  Widget getTagView() {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.minTagViewHeight,
          maxHeight: widget.maxTagViewHeight,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5.0,
            direction: Axis.horizontal,
            children: buildTags(),
          ),
        ));
  }

  List<Widget> buildTags() {
    List<Widget> tags = <Widget>[];

    for (int i = 0; i < widget.tags.length; i++) {
      tags.add(createTag(i, widget.tags[i]));
    }

    return tags;
  }

  Widget createTag(int index, String tagTitle) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTagIndex = index;
        });
      },
      child: Chip(
        backgroundColor: widget.tagBackgroundColor,
        label: widget.tagTitle == null
            ? Text(
                tagTitle,
                style: style.copyWith(
                  color: AppColor.white,
                ),
              )
            : widget.tagTitle!(tagTitle),
        deleteIcon: Icon(
          Icons.cancel_outlined,
          size: 18,
          color: AppColor.red,
        ),
        onDeleted: widget.deletableTag
            ? () {
                if (widget.deletableTag) deleteTag(index);
              }
            : null,
      ),
    );
  }

  void deleteTag(int index) {
    if (widget.onDeleteTag != null)
      widget.onDeleteTag!(index);
    else {
      setState(() {
        widget.tags.removeAt(index);
      });
    }
  }
}    

//  setState(() { widget.tags.removeAt(index)})