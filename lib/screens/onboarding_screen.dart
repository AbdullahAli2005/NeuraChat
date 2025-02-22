import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neura_chat/main.dart';
import 'package:neura_chat/screens/home_screen.dart';

import '../helper/global.dart';
import '../model/onboard.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _pageViewController = PageController();
    final list = [
      // onboarding 1
      Onboard(
        title: 'Ask me Anything',
        subtitle:
            'I can be your Best Friend & You can ask me anything & I will help you!',
        lottie: 'ai_ask_me2',
      ),

      // onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        lottie: 'ai_play',
        subtitle:
            'Just Imagine anything & let me know, I will create something wonderful for you!',
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _pageViewController,
          itemCount: list.length,
          itemBuilder: (context, index) {
            final isLast = index == list.length - 1;
            return Column(
              children: [
                Lottie.asset(
                  'assets/lottie/${list[index].lottie}.json',
                  height: mq.height * 0.6,
                  width: isLast ? mq.width * 0.7 : mq.width*0.85
                ),
                // TITLE
                Text(
                  list[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),

                // SUBTITLE
                SizedBox(
                  width: mq.width * 0.7,
                  child: Text(
                    list[index].subtitle,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: 13,
                      letterSpacing: .5,
                      color: Theme.of(context).lightTextColor,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),
                const Spacer(),

                Wrap(
                  spacing: 10,
                  children: List.generate(
                    list.length,
                    (i) => Container(
                      width: i == index ? 15 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: i == index ? Color.fromARGB(255, 117, 187, 245) : Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 0,
                      backgroundColor: Theme.of(context).buttonColor,
                      minimumSize: Size(mq.width * .4, 50)),
                  onPressed: () {
                    if (isLast) {
                      Get.off(HomeScreen());
                      } else {
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    isLast ? 'Finish' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
