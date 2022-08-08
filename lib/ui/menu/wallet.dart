import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';
import 'package:nche/ui/menu/user_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
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
                  height: screenSize.height * 0.38,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColor.brown,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(screenSize.width, 100.0),
                    ),
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
                                color: AppColor.white,
                                size: 30,
                              ),
                            ),

                            // Page title
                            Text(
                              'My Wallet',
                              style: style.copyWith(
                                fontSize: 18,
                                color: AppColor.darkerYellow,
                              ),
                            ),
                            Expanded(child: Container()),

                            // user profile
                            InkWell(
                              onTap: () => pushNewScreen(
                                context,
                                screen: const UserProfile(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(130),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(130),
                                      child: Image.asset(
                                        'assets/musk.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(130),
                                            child: Image.asset(
                                              'assets/No_image.png',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -1,
                                    top: 5,
                                    child: Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                        color: AppColor.brown,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: 8,
                                        width: 8,
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff00F261),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NCE000.078',
                              style: style.copyWith(
                                color: AppColor.white,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '= \$68,000.90',
                              style: style.copyWith(
                                color: AppColor.darkerGrey,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Today, your holding increased by',
                              style: style.copyWith(
                                color: AppColor.darkerGrey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ' \$23 ',
                              style: style.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_upward,
                              size: 18,
                              color: Colors.green,
                            )
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Container(
                          width: 159,
                          height: 53,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.darkerYellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_outlined,
                                color: AppColor.white,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Receive',
                                style: style.copyWith(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // wallet infor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                children: [
                  // withdrawal
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.wallet_membership_outlined,
                          size: 35,
                          color: AppColor.darkerYellow,
                        ),
                        Text(
                          'Withdrawal',
                          style: style.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  // My card
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.credit_card,
                          size: 35,
                          color: AppColor.darkerYellow,
                        ),
                        Text(
                          'My cards',
                          style: style.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),

                  Expanded(child: Container()),

                  // top Up your wallet

                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.add,
                          size: 35,
                          color: AppColor.darkerYellow,
                        ),
                        Text(
                          'Top up',
                          style: style.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: screenSize.height * 0.24,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        //first
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  'assets/musk.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(130),
                                      child: Image.asset(
                                        'assets/No_image.png',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bitcoin',
                                  style: style,
                                ),
                                Text(
                                  'BTC',
                                  style: style.copyWith(
                                    color: AppColor.darkerGrey,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$138',
                                  style: style,
                                ),
                                Text(
                                  '+2.23%',
                                  style: style.copyWith(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        // second
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  'assets/musk.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(130),
                                      child: Image.asset(
                                        'assets/No_image.png',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Etherium',
                                  style: style,
                                ),
                                Text(
                                  'ETC',
                                  style: style.copyWith(
                                    color: AppColor.darkerGrey,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$15',
                                  style: style,
                                ),
                                Text(
                                  '+1.19%',
                                  style: style.copyWith(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        // third
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(130),
                                child: Image.asset(
                                  'assets/musk.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(130),
                                      child: Image.asset(
                                        'assets/No_image.png',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nche',
                                  style: style,
                                ),
                                Text(
                                  'NCE20',
                                  style: style.copyWith(
                                    color: AppColor.darkerGrey,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$1.32',
                                  style: style,
                                ),
                                Text(
                                  '+2.06%',
                                  style: style.copyWith(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Transaction history
                  Text(
                    'Transactions',
                    style: style.copyWith(
                      color: AppColor.darkerYellow,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFDDDD),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.double_arrow_outlined,
                          color: AppColor.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sell',
                            style: style,
                          ),
                          Text(
                            'NCE20',
                            style: style.copyWith(
                              color: AppColor.darkerGrey,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '-\$305',
                            style: style.copyWith(color: AppColor.red),
                          ),
                          Text(
                            '23 Dec',
                            style: style.copyWith(
                              color: AppColor.darkerGrey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  //
                  Row(
                    children: [
                      Container(
                        height: 43,
                        width: 43,
                        decoration: BoxDecoration(
                          color: const Color(0xffD9FFF8),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.wallet_giftcard,
                          color: Color(0xff188A8A),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reward',
                            style: style,
                          ),
                          Text(
                            'NCE20',
                            style: style.copyWith(
                              color: AppColor.darkerGrey,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '+\$500',
                            style: style.copyWith(color: Colors.green),
                          ),
                          Text(
                            '23 Dec',
                            style: style.copyWith(
                              color: AppColor.darkerGrey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
