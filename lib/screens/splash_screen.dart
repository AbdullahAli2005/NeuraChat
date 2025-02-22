import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/screens/home_screen.dart';
import 'package:neura_chat/screens/onboarding_screen.dart';

import '../helper/global.dart';
import '../widgets/custom_loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //wait for some time on splash & then move to next screen
    Future.delayed(const Duration(seconds: 5), () {
     
      Get.off(const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/splash_screen.png', 
          fit: BoxFit.cover,
        ),
      ),
      // body: SafeArea(
      //   child: Center(
      //     child: SizedBox(
      //       width: double.maxFinite,
      //       child: Column(
      //         children: [
      //           const Spacer(
      //             flex: 2,
      //           ),
      //           Card(
      //             shape: const RoundedRectangleBorder(
      //               borderRadius: BorderRadius.all(
      //                 Radius.circular(20),
      //               ),
      //             ),
      //             child: Padding(
      //               padding: EdgeInsets.all(mq.width * .05),
      //               child: Image.asset(
      //                 "assets/images/chatbot.png",
      //                 width: mq.width * .4,
      //               ),
      //             ),
      //           ),
      //           const Spacer(),
      //           const CustomLoading(),
      //           const Spacer(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
