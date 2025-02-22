import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:neura_chat/apis/api.dart';
import 'package:neura_chat/model/home_type.dart';
import 'package:neura_chat/widgets/home_card.dart';

import '../controllers/theme_controller.dart';
import '../helper/global.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Get.isDarkMode.obs;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    // APIS.getAnswer("Hii");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 14),
            onPressed: () {
              Get.find<ThemeController>().toggleTheme();
            },
            icon: const Icon(
              Icons.brightness_6_outlined,
              size: 28,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.045,
          vertical: mq.height * 0.015,
        ),
        children: [
          ...HomeType.values.map((e) => HomeCard(
                homeType: e,
              )),
        ],
      ),
    );
  }
}
