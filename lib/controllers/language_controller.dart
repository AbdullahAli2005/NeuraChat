import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neura_chat/apis/api.dart';
import 'package:neura_chat/helper/snackbar.dart';

import 'image_controller.dart';

class TranslateController extends GetxController {
  final textController = TextEditingController();
  final resultController = TextEditingController();

  final from = "".obs;
  final to = "".obs;
  final status = Status.none.obs;


  Future<void> translate() async {
    if (textController.text.trim().isNotEmpty && to.isNotEmpty) {
      status.value = Status.loading;

      String prompt;

      if (from.isNotEmpty) {
        prompt =
            'Just translate given text from ${from.value} to ${to.value}:\n${textController.text}.';
      } else {
        prompt = 'Just translate given text to ${to.value}:\n${textController.text}';
      }

      log(prompt);
      final res = await APIS.getAnswer(prompt);
      resultController.text = res;
      // resultController.text = utf8.decode(res.codeUnits);

      status.value = Status.complete;

      // textController.text = "";
    } else {
      status.value = Status.none;
      if (to.isEmpty) SnackbarService.info('Select To Language!');
      if (textController.text.isEmpty) SnackbarService.info('Type Something to Translate!');
    }
  }

  void swapLanguages() {
    if (to.isNotEmpty && from.isNotEmpty) {
      final t = to.value;
      to.value = from.value;
      from.value = t;
    }
  }

  Future<void> googleTranslate() async {
    if (textController.text.trim().isNotEmpty && to.isNotEmpty) {
      status.value = Status.loading;

      resultController.text = await APIS.googleTranslate(
          from: jsonLang[from.value] ?? 'auto',
          to: jsonLang[to.value] ?? 'en',
          text: textController.text);

      status.value = Status.complete;
    } else {
      status.value = Status.none;
      if (to.isEmpty) SnackbarService.info('Select To Language!');
      if (textController.text.isEmpty) {
        SnackbarService.info('Type Something to Translate!');
      }
    }
  }

  // list of languages available
  // final lang = const [
  //   "Afar",
  //   "Abkhazian",
  //   "Avestan",
  //   "Afrikaans",
  //   "Akan",
  //   "Amharic",
  //   "Aragonese",
  //   "Arabic",
  //   "Assamese",
  //   "Avaric",
  //   "Aymara",
  //   "Azerbaijani",
  //   "Bashkir",
  //   "Belarusian",
  //   "Bulgarian",
  //   "Bihari languages",
  //   "Bislama",
  //   "Bambara",
  //   "Bengali",
  //   "Tibetan",
  //   "Breton",
  //   "Bosnian",
  //   "Catalan",
  //   "Chechen",
  //   "Chamorro",
  //   "Corsican",
  //   "Cree",
  //   "Czech",
  //   "Church Slavic",
  //   "Chuvash",
  //   "Welsh",
  //   "Danish",
  //   "German",
  //   "Maldivian",
  //   "Dzongkha",
  //   "Ewe",
  //   "Greek",
  //   "English",
  //   "Esperanto",
  //   "Spanish",
  //   "Estonian",
  //   "Basque",
  //   "Persian",
  //   "Fulah",
  //   "Finnish",
  //   "Fijian",
  //   "Faroese",
  //   "French",
  //   "Western Frisian",
  //   "Irish",
  //   "Gaelic",
  //   "Galician",
  //   "Guarani",
  //   "Gujarati",
  //   "Manx",
  //   "Hausa",
  //   "Hebrew",
  //   "Hindi",
  //   "Hiri Motu",
  //   "Croatian",
  //   "Haitian",
  //   "Hungarian",
  //   "Armenian",
  //   "Herero",
  //   "Interlingua",
  //   "Indonesian",
  //   "Interlingue",
  //   "Igbo",
  //   "Sichuan Yi",
  //   "Inupiaq",
  //   "Ido",
  //   "Icelandic",
  //   "Italian",
  //   "Inuktitut",
  //   "Japanese",
  //   "Javanese",
  //   "Georgian",
  //   "Kongo",
  //   "Kikuyu",
  //   "Kuanyama",
  //   "Kazakh",
  //   "Kalaallisut",
  //   "Central Khmer",
  //   "Kannada",
  //   "Korean",
  //   "Kanuri",
  //   "Kashmiri",
  //   "Kurdish",
  //   "Komi",
  //   "Cornish",
  //   "Kirghiz",
  //   "Latin",
  //   "Luxembourgish",
  //   "Ganda",
  //   "Limburgan",
  //   "Lingala",
  //   "Lao",
  //   "Lithuanian",
  //   "Luba-Katanga",
  //   "Latvian",
  //   "Malagasy",
  //   "Marshallese",
  //   "Maori",
  //   "Macedonian",
  //   "Malayalam",
  //   "Mongolian",
  //   "Marathi",
  //   "Malay",
  //   "Maltese",
  //   "Burmese",
  //   "Nauru",
  //   "Norwegian",
  //   "North Ndebele",
  //   "Nepali",
  //   "Ndonga",
  //   "Dutch",
  //   "South Ndebele",
  //   "Navajo",
  //   "Chichewa",
  //   "Occitan",
  //   "Ojibwa",
  //   "Oromo",
  //   "Oriya",
  //   "Ossetic",
  //   "Panjabi",
  //   "Pali",
  //   "Polish",
  //   "Pushto",
  //   "Portuguese",
  //   "Quechua",
  //   "Romansh",
  //   "Rundi",
  //   "Romanian",
  //   "Russian",
  //   "Kinyarwanda",
  //   "Sanskrit",
  //   "Sardinian",
  //   "Sindhi",
  //   "Northern Sami",
  //   "Sango",
  //   "Sinhala",
  //   "Slovak",
  //   "Slovenian",
  //   "Samoan",
  //   "Shona",
  //   "Somali",
  //   "Albanian",
  //   "Serbian",
  //   "Swati",
  //   "Sotho, Southern",
  //   "Sundanese",
  //   "Swedish",
  //   "Swahili",
  //   "Tamil",
  //   "Telugu",
  //   "Tajik",
  //   "Thai",
  //   "Tigrinya",
  //   "Turkmen",
  //   "Tagalog",
  //   "Tswana",
  //   "Tonga",
  //   "Turkish",
  //   "Tsonga",
  //   "Tatar",
  //   "Twi",
  //   "Tahitian",
  //   "Uighur",
  //   "Ukrainian",
  //   "Urdu",
  //   "Uzbek",
  //   "Venda",
  //   "Vietnamese",
  //   "Volapük",
  //   "Walloon",
  //   "Wolof",
  //   "Xhosa",
  //   "Yiddish",
  //   "Yoruba",
  //   "Zhuang",
  //   "Chinese",
  //   "Zulu"
  // ];  
    
    late final lang = jsonLang.keys.toList();

  final jsonLang = const {
    // 'Automatic': 'auto',
    // 'Afrikaans': 'af',
    'Albanian': 'sq',
    'Amharic': 'am',
    'Arabic': 'ar',
    'Armenian': 'hy',
    'Assamese': 'as',
    'Aymara': 'ay',
    'Azerbaijani': 'az',
    'Bambara': 'bm',
    'Basque': 'eu',
    'Belarusian': 'be',
    'Bengali': 'bn',
    'Bhojpuri': 'bho',
    'Bosnian': 'bs',
    'Bulgarian': 'bg',
    'Catalan': 'ca',
    'Cebuano': 'ceb',
    'Chinese (Simplified)': 'zh-cn',
    'Chinese (Traditional)': 'zh-tw',
    'Corsican': 'co',
    'Croatian': 'hr',
    'Czech': 'cs',
    'Danish': 'da',
    'Dhivehi': 'dv',
    'Dogri': 'doi',
    'Dutch': 'nl',
    'English': 'en',
    'Esperanto': 'eo',
    'Estonian': 'et',
    'Ewe': 'ee',
    'Filipino (Tagalog)': 'tl',
    'Finnish': 'fi',
    'French': 'fr',
    'Frisian': 'fy',
    'Galician': 'gl',
    'Georgian': 'ka',
    'German': 'de',
    'Greek': 'el',
    'Guarani': 'gn',
    'Gujarati': 'gu',
    'Haitian Creole': 'ht',
    'Hausa': 'ha',
    'Hawaiian': 'haw',
    'Hebrew': 'iw',
    'Hindi': 'hi',
    'Hmong': 'hmn',
    'Hungarian': 'hu',
    'Icelandic': 'is',
    'Igbo': 'ig',
    'Ilocano': 'ilo',
    'Indonesian': 'id',
    'Irish': 'ga',
    'Italian': 'it',
    'Japanese': 'ja',
    'Javanese': 'jw',
    'Kannada': 'kn',
    'Kazakh': 'kk',
    'Khmer': 'km',
    'Kinyarwanda': 'rw',
    'Konkani': 'gom',
    'Korean': 'ko',
    'Krio': 'kri',
    'Kurdish (Kurmanji)': 'ku',
    'Kurdish (Sorani)': 'ckb',
    'Kyrgyz': 'ky',
    'Lao': 'lo',
    'Latin': 'la',
    'Latvian': 'lv',
    'Lithuanian': 'lt',
    'Luganda': 'lg',
    'Luxembourgish': 'lb',
    'Macedonian': 'mk',
    'Malagasy': 'mg',
    'Maithili': 'mai',
    'Malay': 'ms',
    'Malayalam': 'ml',
    'Maltese': 'mt',
    'Maori': 'mi',
    'Marathi': 'mr',
    'Meiteilon (Manipuri)': 'mni-mtei',
    'Mizo': 'lus',
    'Mongolian': 'mn',
    'Myanmar (Burmese)': 'my',
    'Nepali': 'ne',
    'Norwegian': 'no',
    'Nyanja (Chichewa)': 'ny',
    'Odia (Oriya)': 'or',
    'Oromo': 'om',
    'Pashto': 'ps',
    'Persian': 'fa',
    'Polish': 'pl',
    'Portuguese': 'pt',
    'Punjabi': 'pa',
    'Quechua': 'qu',
    'Romanian': 'ro',
    'Russian': 'ru',
    'Samoan': 'sm',
    'Sanskrit': 'sa',
    'Scots Gaelic': 'gd',
    'Sepedi': 'nso',
    'Serbian': 'sr',
    'Sesotho': 'st',
    'Shona': 'sn',
    'Sindhi': 'sd',
    'Sinhala': 'si',
    'Slovak': 'sk',
    'Slovenian': 'sl',
    'Somali': 'so',
    'Spanish': 'es',
    'Sundanese': 'su',
    'Swahili': 'sw',
    'Swedish': 'sv',
    'Tajik': 'tg',
    'Tamil': 'ta',
    'Tatar': 'tt',
    'Telugu': 'te',
    'Thai': 'th',
    'Tigrinya': 'ti',
    'Tsonga': 'ts',
    'Turkish': 'tr',
    'Turkmen': 'tk',
    'Twi (Akan)': 'ak',
    'Ukrainian': 'uk',
    'Urdu': 'ur',
    'Uyghur': 'ug',
    'Uzbek': 'uz',
    'Vietnamese': 'vi',
    'Welsh': 'cy',
    'Xhosa': 'xh',
    'Yiddish': 'yi',
    'Yoruba': 'yo',
    'Zulu': 'zu'
  };
}
