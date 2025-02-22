import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/controllers/language_controller.dart';
import 'package:neura_chat/main.dart';
import 'package:neura_chat/widgets/custom_button.dart';
import 'package:neura_chat/widgets/language_sheet.dart';

import '../controllers/image_controller.dart';
import '../helper/global.dart';
import '../widgets/custom_loading.dart';

class LanguageTranslatorScreen extends StatefulWidget {
  const LanguageTranslatorScreen({super.key});

  @override
  State<LanguageTranslatorScreen> createState() =>
      _LanguageTranslatorScreenState();
}

class _LanguageTranslatorScreenState extends State<LanguageTranslatorScreen> {
  final _controller = TranslateController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * 0.02,
          bottom: mq.height * 0.08,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // From
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(
                  controller: _controller,
                  string: _controller.from,
                )),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(
                    () => Text(_controller.from.isEmpty
                        ? "Auto"
                        : _controller.from.value),
                  ),
                ),
              ),
              IconButton(
                onPressed: _controller.swapLanguages,
                icon: Obx(
                  () => Icon(
                    CupertinoIcons.repeat,
                    color:
                        _controller.to.isNotEmpty && _controller.from.isNotEmpty
                            ? Colors.blue
                            : Colors.grey,
                  ),
                ),
              ),
              // TO
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(
                  controller: _controller,
                  string: _controller.to,
                )),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(
                    () => Text(
                        _controller.to.isEmpty ? "To" : _controller.to.value),
                  ),
                ),
              ),
            ],
          ),
          // TEXT
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04, vertical: mq.height * 0.04),
            child: TextFormField(
              controller: _controller.textController,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                filled: true,
                hintText: 'Translate anything you want...',
                hintStyle:  TextStyle(fontSize: 14, color:  Theme.of(context).lightTextColor),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          // RESULT
          Obx(
            () => _translateResult(),
          ),
          SizedBox(
            height: mq.height * 0.04,
          ),
          CustomBtn(onTap: _controller.googleTranslate, text: "Translate")
        ],
      ),
    );
  }

  Widget _translateResult() => switch (_controller.status.value) {
        Status.none => const SizedBox(),
        Status.complete => Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
            child: TextFormField(
              controller: _controller.resultController,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        Status.loading => const Align(child: CustomLoading())
      };
}
