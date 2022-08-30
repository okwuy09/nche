import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';

class DateField extends StatelessWidget {
  final String pickedDate;
  final Function()? onPressed;
  const DateField({Key? key, required this.pickedDate, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColor.lightGrey,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              pickedDate,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 38,
            width: 38,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.lightOrange,
                borderRadius: BorderRadius.circular(6)),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xffF57E5B),
                ),
                onPressed: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
