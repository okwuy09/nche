import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 20),
            Text(
              'Terms and Condition',
              style: style.copyWith(
                fontSize: 18,
                color: AppColor.darkerYellow,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you across our APP, and other software we own and operate. ',
              style: style.copyWith(
                color: AppColor.darkerGrey,
              ),
              textAlign: TextAlign.center,
            ),
            //
            SizedBox(height: screenSize.height * 0.035),
            Text(
              'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we\'re collecting it and how it will be used.',
              style: style.copyWith(
                color: AppColor.darkerGrey,
              ),
              textAlign: TextAlign.center,
            ),
            //
            SizedBox(height: screenSize.height * 0.035),
            Text(
              'We only retain collected information for as long as necessary to provide you with your requested service. ',
              style: style.copyWith(
                color: AppColor.darkerGrey,
              ),
              textAlign: TextAlign.center,
            ),
            //
            SizedBox(height: screenSize.height * 0.1),
            Text(
              'Terms & Condition',
              style: style,
            ),
            //
            const SizedBox(height: 10),
            Text(
              'Privacy Police',
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
