import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/main.dart';

import '../controllers/language_controller.dart';
import '../helper/global.dart';

class LanguageSheet extends StatefulWidget {
  final TranslateController controller;
  final RxString string;

  const LanguageSheet(
      {super.key, required this.controller, required this.string});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  final _search = "".obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.5,
      padding: EdgeInsets.only(
          left: mq.width * .04, right: mq.width * .04, top: mq.height * .02),
      decoration: BoxDecoration(
        // color:  Theme.of(context).cardColor,
        color: Colors.blue[200],
        // color: Colors.blue[300],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            onChanged: (s) => _search.value = s.toLowerCase(),
            // controller: _controller.resultController,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.translate_outlined,
                color: Colors.blue,
              ),
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: 'Search Language...',
              hintStyle: const TextStyle(fontSize: 14),
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final List<String> list = _search.isEmpty
                    ? widget.controller.lang
                    : widget.controller.lang
                        .where((e) => e.toLowerCase().contains(_search.value))
                        .toList();
                return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * 0.02, left: 4),
                  itemBuilder: (context, index) {
                    return Card(
                      
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: InkWell(
                          onTap: () {
                            widget.string.value = list[index];
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: mq.height * 0.02),
                            child: Align(child: Text(list[index])),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
