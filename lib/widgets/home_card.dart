import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:neura_chat/main.dart';

import '../helper/global.dart';
import '../model/home_type.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.homeType});

  final HomeType homeType;

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.only(bottom: mq.height * 0.02),
      // color: Colors.blue[100],
      color: Theme.of(context).buttonColor,
      // color: Colors.blue.withOpacity(0.6),
      child: InkWell(
        onTap: homeType.onTap,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child:  homeType.leftAlign
          ? Row(
              children: [
                Container(
                  padding: homeType.padding,
                  width: mq.width * 0.35,
                  child: Lottie.asset(
                    "assets/lottie/${homeType.lottie}",
                  ),
                ),
                const Spacer(),
                Text(
                  homeType.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            )
          : Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text(
                  homeType.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: homeType.padding,
                  width: mq.width * 0.35,
                  child: Lottie.asset(
                    "assets/lottie/${homeType.lottie}",
                  ),
                ),
              ],
            ),
      ),
    ).animate().fade(duration: 1.2.seconds, curve: Curves.easeIn);
  }
}
