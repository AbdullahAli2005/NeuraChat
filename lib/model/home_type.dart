import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/screens/chatbot_page.dart';
import 'package:neura_chat/screens/image_generator_screen.dart';
import 'package:neura_chat/screens/lang_translator.dart';

enum HomeType { aiChatBot, aiImage, aiTranslator }

extension MyHomeType on HomeType {
  // Name
  String get title => switch (this) {
        HomeType.aiChatBot => "AI ChatBot",
        HomeType.aiImage => "AI Image Creator",
        HomeType.aiTranslator => "Language Translator",
      };

  // Lottie
  String get lottie => switch (this) {
        HomeType.aiChatBot => "ai_hand_waving.json",
        HomeType.aiImage => "ai_play.json",
        HomeType.aiTranslator => "ai_ask_me2.json",
      };

  // For Alignment
  bool get leftAlign => switch (this) {
        HomeType.aiChatBot => true,
        HomeType.aiImage => false,
        HomeType.aiTranslator => true,
      };

  // For Padding
  EdgeInsets get padding => switch (this) {
        HomeType.aiChatBot => EdgeInsets.zero,
        HomeType.aiImage => const EdgeInsets.all(20),
        HomeType.aiTranslator => const EdgeInsets.all(10),
      };

  // For Navigation
  VoidCallback get onTap => switch (this) {
        HomeType.aiChatBot => () => Get.to(() => const ChatbotScreen()),
        HomeType.aiImage => () => Get.to(() => const ImageGeneratorScreen()),
        HomeType.aiTranslator => () => Get.to(() => const LanguageTranslatorScreen()),
      };
}
