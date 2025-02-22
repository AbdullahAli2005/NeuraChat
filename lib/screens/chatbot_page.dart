import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/controllers/chat_controller.dart';
import 'package:neura_chat/widgets/message_card.dart';

import '../helper/global.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI Assistant'),
      ),
      body: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(),
          controller: _controller.scrollController,
          padding: EdgeInsets.only(top: mq.height*0.02, bottom: mq.height*0.08),
            children:
                _controller.list.map((e) => MessageCard(message: e)).toList()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller.textEditingController,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  isDense: true,
                  hintText: 'Ask me anything you want...',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 22,
              child: IconButton(
                onPressed: _controller.askObject,
                icon: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
