import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neura_chat/controllers/image_controller.dart';
import 'package:neura_chat/main.dart';
import 'package:neura_chat/widgets/custom_button.dart';
import 'package:neura_chat/widgets/custom_loading.dart';

import '../helper/global.dart';

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  final _controller = ImageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Generator'),
        actions: [
          Obx(
            () => _controller.status.value == Status.complete
                ? IconButton(
                    onPressed: _controller.shareImage,
                    padding: EdgeInsets.only(right: 8),
                    icon: const Icon(
                      Icons.share,
                    ),
                  )
                : SizedBox(),
          )
        ],
      ),
      floatingActionButton: Obx(
        () => _controller.status.value == Status.complete
            ? Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 6),
                child: FloatingActionButton(
                  elevation: 3,
                  onPressed: _controller.shareImage,
                  backgroundColor: Theme.of(context).buttonColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Icon(
                    Icons.save_alt_rounded,
                    size: 26,
                  ),
                ),
              )
            : const SizedBox(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: mq.height * 0.02,
            bottom: mq.height * 0.08,
            left: mq.width * .04,
            right: mq.width * .04),
        children: [
          TextFormField(
            controller: _controller.textController,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            decoration: InputDecoration(
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              filled: true,
              hintText:
                  'Imagine something wonderful & innovative\nType here & I will create for you 😃',
              hintStyle:  TextStyle(fontSize: 14, color:  Theme.of(context).lightTextColor),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Container(
            height: mq.height * 0.5,
            alignment: Alignment.center,
            child: _aiImage(),
          ),
          CustomBtn(onTap: _controller.createAIImage, text: 'Create'),
        ],
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Obx(() {
          switch (_controller.status.value) {
            case Status.none:
              return Lottie.asset('assets/lottie/ai_play.json',
                  height: mq.height * .3);
            case Status.complete:
              if (_controller.url.value.isNotEmpty) {
                try {
                  final decodedBytes =
                      base64Decode(_controller.url.value.split(',')[1]);
                  return Image.memory(decodedBytes);
                } catch (e) {
                  return const Text("Failed to display image");
                }
              } else {
                return const Text("Failed to generate image");
              }
            case Status.loading:
              return const CustomLoading();
          }
        }),
      );
}
