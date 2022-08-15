import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/homepage/claim_reward.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: screenSize.height * 0.32,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColor.black,
                              ),
                            ),

                            // Page title
                            Expanded(child: Container()),
                            Text(
                              'Rewards',
                              style: style.copyWith(
                                fontSize: 18,
                                color: AppColor.darkerYellow,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),

                        //issue reward button
                        SizedBox(height: screenSize.height * 0.04),
                        MainButton(
                          borderColor: Colors.transparent,
                          child: Text(
                            'ISSUE OUT A REWARD',
                            style: style.copyWith(
                              fontSize: 14,
                              color: const Color(0xff188A8A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: const Color(0xffD9FFF8),
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Apply to issue out a bounty/reward against an incident or perpetrator',
                          style: style.copyWith(
                            fontSize: 14,
                            color: AppColor.darkerGrey,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: screenSize.height * 0.7,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(57),
                  topRight: Radius.circular(57),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.035),
                  Text(
                    'Open rewards for claim',
                    style: style,
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ClaimReward(),
                              ),
                            ),
                            child: Container(
                              height: 69,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                children: [
                                  // image
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/musk.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Benefactor',
                                        style: style.copyWith(
                                          color: AppColor.darkerGrey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Nigerian police Force NPF',
                                        style: style.copyWith(fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Expires: 9th may, 2021',
                                        style: style.copyWith(
                                          color: AppColor.darkerGrey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Reward',
                                        style: style.copyWith(
                                          color: AppColor.darkerGrey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\$250',
                                        style: style.copyWith(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
