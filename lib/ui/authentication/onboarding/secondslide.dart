import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class SecondSlide extends StatelessWidget {
  const SecondSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Container(
      color: AppColor.lightgreen,
      child: Padding(
        padding: const EdgeInsets.only(top: 68),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: 270,
            width: screensize.width,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(120),
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Lorem Ipsum',
                style: style.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 14),
              const Text(
                'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.\n Et vestibulum facilisis nulla.',
                textAlign: TextAlign.center,
              )
            ]),
          )
        ]),
      ),
    );
  }
}
