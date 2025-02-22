import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:neura_chat/helper/snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/global.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  // final textEditingController = TextEditingController();

  // final textController = TextEditingController();
  // final textController = TextEditingController();

  final textEditingController = TextEditingController();
  final textController = TextEditingController();

  final status = Status.none.obs;

  final url = ''.obs; // To store generated image URL
  final imageList = <String>[].obs;

  Future<void> createAIImage() async {
    if (textController.text.trim().isNotEmpty) {
      status.value = Status.loading;

      const String apiUrl =
          "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-2";

      Map<String, String> headers = {
        "Authorization": "Bearer $huggingApi",
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        "inputs": textController.text, // Prompt
        "options": {"wait_for_model": true}
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          // Hugging Face returns the image as raw bytes, so you need to convert it
          final imageBytes = response.bodyBytes;
          final base64Image = base64Encode(imageBytes);
          url.value =
              "data:image/png;base64,$base64Image"; // Convert to displayable format
        } else {
          print("Error: ${response.body}");
          url.value = ''; // Clear the previous image
        }
      } catch (e) {
        print("API Error: $e");
      }

      status.value = Status.complete;
    } else {
      // Show error message
      SnackbarService.info('Provide some beautiful image description!');
    }
  }

  void shareImage() async {
    try {
      // Show loading
      SnackbarService.showLoadingDialog();

      if (url.value.isEmpty || !url.value.contains(',')) {
        throw Exception("Invalid image data");
      }

      // Extract base64 data from the `data:image/png;base64,xxxxx` string
      final base64String = url.value.split(',')[1];

      // Decode Base64
      final decodedBytes = base64Decode(base64String);

      // Save image to a temporary file
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/ai_image.png');
      await file.writeAsBytes(decodedBytes);

      // Hide loading
      Get.back();

      // Share the saved image
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out this amazing AI-generated image!',
      );
    } catch (e) {
      // Hide loading and show error
      Get.back();
      SnackbarService.error('Something went wrong! Try again later.');
      log('shareImageError: $e');
    }
  }

 

// Future<void> downloadImage() async {
//   var status = await Permission.storage.request();
//   if (!status.isGranted) {
//     SnackbarService.error('Storage permission denied');
//     return;
//   }
//   try {
//     // Show loading
//     SnackbarService.showLoadingDialog();

//     if (url.value.isEmpty || !url.value.contains(',')) {
//       throw Exception("Invalid image data");
//     }

//     // Extract base64 string (removing "data:image/png;base64,")
//     final base64String = url.value.split(',')[1];

//     // Decode Base64 to bytes
//     Uint8List imageBytes = base64Decode(base64String);

//     // Save the image to the gallery
//     final result = await ImageGallerySaver.saveImage(imageBytes, quality: 100, name: "ai_image");

//     // Hide loading
//     Get.back();

//     if (result['isSuccess']) {
//       SnackbarService.success('Image saved to gallery!');
//     } else {
//       throw Exception("Failed to save image");
//     }
//   } catch (e) {
//     // Hide loading and show error
//     Get.back();
//     SnackbarService.error('Failed to download image. Try again!');
//     debugPrint('downloadImageError: $e');
//   }
// }


}


