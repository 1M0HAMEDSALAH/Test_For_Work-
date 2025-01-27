// // import 'package:get/get.dart';
// // import 'package:translator/translator.dart';

// // class TranslationController extends GetxController {
// //   static TranslationController get to => Get.find();
// //   final GoogleTranslator _translator = GoogleTranslator();

// //   // Observable language code
// //   final RxString _currentLanguage = 'ar'.obs;
// //   String get currentLanguage => _currentLanguage.value;

// //   // Change language
// //   void changeLanguage(String langCode) {
// //     _currentLanguage.value = langCode;
// //     update(); // Trigger update for GetBuilder widgets
// //   }

// //   // Translate text
// //   Future<String> translateText(String text) async {
// //     if (text.isEmpty || _currentLanguage.value == 'en') {
// //       return text;
// //     }

// //     try {
// //       final translation = await _translator.translate(
// //         text,
// //         to: _currentLanguage.value,
// //       );
// //       return translation.text;
// //     } catch (e) {
// //       printError(info: 'Translation error: $e');
// //       return text;
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:translator/translator.dart';

// // Controller for managing translation state
// class TranslationController extends GetxController {
//   final translator = GoogleTranslator();
//   final storage = GetStorage();
  
//   var originalText = ''.obs;
//   var translatedText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Load saved translations if they exist
//     originalText.value = storage.read('originalText') ?? '';
//     translatedText.value = storage.read('translatedText') ?? '';
//   }

//   Future<void> translateText(String text) async {
//     if (text.isEmpty) return;

//     try {
//       originalText.value = text;
      
//       // Translate to Arabic
//       final translation = await translator.translate(
//         text,
//         from: 'auto',
//         to: 'ar',
//       );
      
//       translatedText.value = translation.text;
      
//       // Save to storage
//       storage.write('originalText', text);
//       storage.write('translatedText', translation.text);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Translation failed. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }