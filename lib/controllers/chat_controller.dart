import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/apis/api.dart';
import 'package:neura_chat/helper/snackbar.dart';

import '../model/message.dart';

class ChatController extends GetxController {
  final textEditingController = TextEditingController();
    final scrollController = ScrollController();


  final list = <Message>[
    Message(message: 'Hello, How can I help you?', messageType: MessageType.bot)
  ].obs;

  Future<void> askObject() async {
    if (textEditingController.text.trim().isNotEmpty) {
      // User
      list.add(
        Message(
          message: textEditingController.text,
          messageType: MessageType.user,
        ),
      );
      list.add(Message(message: '', messageType: MessageType.bot));
      _scrollDown();

      final res = await APIS.getAnswer(textEditingController.text);

      // AI Bot
      list.removeLast();
      list.add(
        Message(
          message: res,
          messageType: MessageType.bot,
        ),
      );
      _scrollDown();

      textEditingController.text = "";
    } else {
      SnackbarService.info("Ask Something...");
    }
  }

  void _scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
