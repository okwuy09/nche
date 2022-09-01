import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nche/components/add_contact_sheet.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/widget/home_container.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/ui/Feed/tapbar.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:nche/ui/homepage/claim_reward.dart';
import 'package:nche/ui/homepage/direct_message.dart';
import 'package:nche/ui/homepage/live_incident.dart';
import 'package:nche/ui/homepage/report_incident.dart';
import 'package:nche/ui/homepage/reward_screen.dart';
import 'package:nche/ui/menu/user_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  bool selected = false;
  bool onComplete = false;

  @override
  void initState() {
    // initilizing the image animation inside homepage,
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          selected = !selected;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              height: 110,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => pushNewScreen(
                      context,
                      screen: const UserProfile(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    ),
                    child: Stack(
                      children: [
                        StreamBuilder<Users>(
                          stream: provider.userProfile(context).asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var userImage = snapshot.data?.avarter;
                              return CircleAvatar(
                                backgroundColor: AppColor.white,
                                backgroundImage: userImage!.isNotEmpty
                                    ? NetworkImage(userImage)
                                    : const AssetImage('assets/avatar.png')
                                        as ImageProvider,
                                maxRadius: 20,
                                onBackgroundImageError:
                                    (exception, stackTrace) =>
                                        Image.asset('assets/avatar.png'),
                              );
                            }
                            return CircleAvatar(
                              maxRadius: 20,
                              backgroundColor: AppColor.white,
                              backgroundImage:
                                  const AssetImage('assets/avatar.png'),
                            );
                          },
                        ),
                        Positioned(
                          right: -1,
                          top: 5,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                              height: 8,
                              width: 8,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: const Color(0xff00F261),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: screenSize.width * 0.46,
                    child: CupertinoSearchTextField(
                      decoration: BoxDecoration(
                        color: AppColor.lightGrey,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColor.lightGrey),
                      ),
                      onChanged: (value) => {},
                      onSubmitted: (value) => {},
                    ),
                  ),
                  const SizedBox(width: 6),
                  Image.asset(
                    'assets/nche_logo.png',
                    width: 100,
                    height: 50,
                  ),
                ],
              ),
            ),
            Container(
              height: screenSize.height * 0.79,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // report incident from home page
                        InkWell(
                          onTap: () => pushNewScreen(
                            context,
                            screen: const ReportIncident(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: HomeContainer(
                            icon: Icon(
                              Icons.report,
                              color: AppColor.white,
                            ),
                            iconBackgroundColor: AppColor.brown,
                            title: 'Report\nIncident',
                          ),
                        ),
                        screenSize.width > 600
                            ? const SizedBox(width: 20)
                            : Expanded(child: Container()),

                        // reward from home page
                        InkWell(
                          onTap: () => pushNewScreen(
                            context,
                            screen: const RewardScreen(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: const HomeContainer(
                            icon: Icon(
                              Icons.wallet_giftcard,
                              color: Color(0xff188A8A),
                            ),
                            iconBackgroundColor: Color(0xffD9FFF8),
                            title: 'Rewards',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // add emergency number from home page
                        InkWell(
                          onTap: () => handleAddContact(
                            context: context,
                            nameController: _fullName,
                            phoneController: _phoneNumber,
                            onTap: () {},
                          ),
                          child: HomeContainer(
                            icon: Icon(
                              Icons.person_add_alt_1_outlined,
                              color: AppColor.orange,
                            ),
                            iconBackgroundColor: AppColor.lightOrange,
                            title: 'Add\nEmergency\nContact',
                          ),
                        ),

                        // Direct messaging from home page
                        screenSize.width > 600
                            ? const SizedBox(width: 20)
                            : Expanded(child: Container()),
                        InkWell(
                          onTap: () => pushNewScreen(
                            context,
                            screen: const DirectMessage(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: HomeContainer(
                            icon: Icon(
                              Icons.chat_outlined,
                              color: AppColor.primaryColor,
                            ),
                            iconBackgroundColor: AppColor.lighterOrange,
                            title: 'Direct\nMessages',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //
                        // access News feed from home page
                        InkWell(
                          onTap: () => pushNewScreen(
                            context,
                            screen: const MyTapBar(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: HomeContainer(
                            icon: Icon(
                              Icons.feed_outlined,
                              color: AppColor.black,
                            ),
                            iconBackgroundColor: AppColor.lighterOrange,
                            title: 'News Feed',
                          ),
                        ),
                        screenSize.width > 600
                            ? const SizedBox(width: 20)
                            : Expanded(child: Container()),

                        // live boardcast from home page
                        InkWell(
                          onTap: () => pushNewScreen(
                            context,
                            screen: const LiveIncidents(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: HomeContainer(
                            icon: Icon(
                              Icons.online_prediction,
                              color: AppColor.red,
                            ),
                            iconBackgroundColor: const Color(0xffFFDDDD),
                            title: 'Live',
                          ),
                        ),
                      ],
                    ),
                    //

                    Stack(
                      children: [
                        AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                          margin: EdgeInsets.only(
                            top: screenSize.height * 0.065,
                            bottom: screenSize.height * 0.02,
                          ),
                          height: screenSize.height * 0.126,
                          width: selected
                              ? screenSize.width
                              : screenSize.width * 0.95,
                          decoration: BoxDecoration(
                            color: AppColor.brown,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 38),
                                child: Container(
                                  height: 20,
                                  width: 57,
                                  color: AppColor.black,
                                  child: Center(
                                    child: Text(
                                      'Nche tips',
                                      style: style.copyWith(
                                        fontSize: 10,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.02),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, bottom: 3),
                                child: Text(
                                  'Memorise at least\none friend\' contact',
                                  style: style.copyWith(color: AppColor.white),
                                ),
                              )
                            ],
                          ),
                          onEnd: () {
                            setState(() {
                              selected = !selected;
                              onComplete = !onComplete;
                            });
                          },
                        ),
                        Positioned(
                          top: 0,
                          left: onComplete
                              ? screenSize.width * 0.1
                              : screenSize.width * 0.08,
                          child: Image.asset(
                            'assets/picture.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Open for claim',
                      style: style,
                    ),
                    const SizedBox(height: 10),
                    //
                    SizedBox(
                      height: screenSize.height * 0.163,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () => pushNewScreen(
                                context,
                                screen: const ClaimReward(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ),
                              child: Container(
                                height: 69,
                                width: screenSize.width,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 49,
                                      width: 49,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.lightGrey),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/arm.png'),
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
                                            fontSize: 10,
                                            color: AppColor.grey,
                                          ),
                                        ),
                                        //
                                        const SizedBox(height: 5),
                                        Text(
                                          'Nigeria police Force NPF',
                                          style: style.copyWith(fontSize: 12),
                                        ),
                                        //
                                        const SizedBox(height: 5),
                                        Text(
                                          'Expires: 5th july, 2022',
                                          style: style.copyWith(
                                            fontSize: 10,
                                            color: AppColor.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Container(
                                      height: 47,
                                      width: 60,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffE4FFE6),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reward:',
                                            style: style.copyWith(
                                              fontSize: 10,
                                              color: AppColor.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '\$5000',
                                            style: style.copyWith(
                                              fontSize: 14,
                                              color: const Color(0xff4CAF50),
                                            ),
                                          )
                                        ],
                                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   List<String> searchTerms = [
//     'Apple',
//     'Banana',
//     'Pear',
//     'Watermelons',
//     'Oranges',
//     'Blueberries',
//     'Strawberries',
//     'Raspberries',
//   ];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }
