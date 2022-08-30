import 'package:flutter/material.dart';
import 'package:nche/widget/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/components/successful_bounty_claim.dart';

class ClaimReward extends StatefulWidget {
  const ClaimReward({Key? key}) : super(key: key);

  @override
  State<ClaimReward> createState() => _ClaimRewardState();
}

class _ClaimRewardState extends State<ClaimReward> {
  final TextEditingController _statement = TextEditingController();
  final _globalFormKey = GlobalKey<FormState>();
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Form(
          key: _globalFormKey,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    //height: screenSize.height * 0.32,
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
                                'Claim Reward',
                                style: style.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(flex: 2, child: Container()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                //height: screenSize.height * 0.65,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(8),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                        ],
                      ),
                    ),
                    //
                    SizedBox(height: screenSize.height * 0.03),
                    Text(
                      'Benefactor’s message:',
                      style: style.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Venenatis, morbi a, egestas odio ultrices scelerisque sed urna ornare. Porta facilisis volutpat duis massa facilisis nullam. Etiam gravida facilisi diam rhoncus.',
                      style: style.copyWith(
                        color: AppColor.darkerGrey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Text(
                      'Attached hints/clues:',
                      style: style.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //
                    SizedBox(height: screenSize.height * 0.01),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.video_library_outlined,
                            size: 40,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Media',
                                style: style.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '3 photos, 2 videos',
                                style: style.copyWith(
                                  fontSize: 12,
                                  color: AppColor.darkerGrey,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          // download
                          TextButton(
                            child: const Text('DOWNLOAD'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Text(
                      'Write Statement:',
                      style: style.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    TextFormField(
                      controller: _statement,
                      validator: (input) =>
                          (input!.isEmpty) ? "Enter Your Statement" : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: AppColor.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: AppColor.darkerYellow,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 10.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        hintStyle: style.copyWith(color: AppColor.grey),
                        hintText: 'Write your statement',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      checkColor: AppColor.white,
                      activeColor: AppColor.darkerYellow,
                      side: BorderSide(
                        color: AppColor.darkerYellow,
                        style: BorderStyle.solid,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: ischecked,
                      onChanged: (value) {
                        setState(() {
                          ischecked = value!;
                        });
                      },
                    ),
                    //
                    Text(
                      'I agree that above statement is true and consented',
                      style: style.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.1),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 5),
        child: MainButton(
          borderColor: Colors.transparent,
          child: Text(
            'CLAIM REWARD',
            style: style.copyWith(
              fontSize: 14,
              color: ischecked ? AppColor.black : AppColor.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor:
              ischecked ? AppColor.darkerYellow : AppColor.lightGrey,
          onTap: () {
            if (ischecked) {
              if (_globalFormKey.currentState!.validate()) {
                handleSuccessfulBountyClaim(context: context);
              }
            }
          },
        ),
      ),
    );
  }
}
