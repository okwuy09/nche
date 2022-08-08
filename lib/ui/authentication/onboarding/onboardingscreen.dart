import 'package:flutter/material.dart';
import 'package:nche/components/button.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/authentication/onboarding/firstslide.dart';
import 'package:nche/ui/authentication/onboarding/secondslide.dart';
import 'package:nche/ui/authentication/onboarding/thirdslide.dart';
import 'package:nche/ui/authentication/signin/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

//dispose the pageView controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
            onPageChanged: (index) {
              // assign the index of the last page to a bool variable
              setState(() => isLastPage = index == 2);
            },
            controller: controller,
            // slide pages
            children: const [FirstSlide(), SecondSlide(), ThirdSlide()]),
      ),
      bottomSheet: Container(
        color: AppColor.white,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),

            //  smoothpageindicator package to sow the current page with circular dots
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  radius: 500,
                  dotWidth: 6,
                  dotHeight: 6,
                  dotColor: AppColor.grey,
                  activeDotColor: AppColor.primaryColor,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),

            !isLastPage
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        InkWell(
                          //Click to move to the next slide
                          onTap: () => controller.jumpToPage(2),
                          child: Text(
                            'Skip',
                            style: style,
                          ),
                        ),
                        Expanded(child: Container()),
                        Stack(
                          children: [
                            Container(
                              height: 77,
                              width: 77,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(130),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 18,
                              child: InkWell(
                                onTap: () => controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                ),
                                child: Container(
                                  height: 39,
                                  width: 39,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(130),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 26,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 35,
                    ),
                    child: MainButton(
                      borderColor: Colors.transparent,
                      text: 'GET STARTED',
                      backgroundColor: AppColor.primaryColor,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignIn(),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
