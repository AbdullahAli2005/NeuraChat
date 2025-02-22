import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:neura_chat/main.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../helper/global.dart';
import '../model/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.messageType == MessageType.bot
        ?
        // Bot
        Row(
            children: [
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.4),
                radius: 20,
                child: Image.asset(
                  "assets/images/chatbot.png",
                  width: 24,
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: mq.width * 0.6),
                margin: EdgeInsets.only(
                    bottom: mq.height * 0.02, left: mq.height * 0.014),
                padding: EdgeInsets.symmetric(
                    horizontal: mq.height * 0.01, vertical: mq.width * 0.03),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).lightTextColor),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: message.message.isEmpty
                    ? AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText(
                          ' Please wait... ',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ], repeatForever: true)
                    :
                    // Text(
                    //     message.message,
                    //   ),
                    MarkdownBody(
                        data: message.message, // Enables Markdown formatting
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(fontSize: 16),
                          h1: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          h2: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          h3: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          strong: const TextStyle(fontWeight: FontWeight.bold),
                          blockquoteDecoration: BoxDecoration(
                            border: const Border(
                                left: BorderSide(color: Colors.blue, width: 4)),
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          code: TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                            color: Colors.redAccent, // Inline code color
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                      ),
              ),
            ],
          )
        :
        // User
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: mq.width * 0.6),
                margin: EdgeInsets.only(
                    bottom: mq.height * 0.02, right: mq.height * 0.014),
                padding: EdgeInsets.symmetric(
                    horizontal: mq.height * 0.01, vertical: mq.width * 0.03),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).lightTextColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    )),
                child: message.message.isEmpty
                    ? AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText(
                          ' Please wait... ',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ], repeatForever: true)
                    : Text(
                        message.message,
                      ),
              ),
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.3),
                radius: 18,
                child: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
            ],
          );
  }
}
