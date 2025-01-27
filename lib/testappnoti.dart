// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// import 'controller.dart';

// class TranslationApp extends StatelessWidget {
//   TranslationApp({Key? key}) : super(key: key);

//   final TextEditingController _textController = TextEditingController();
//   final TranslationController controller = Get.put(TranslationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Text Translator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Input text field
//             TextField(
//               controller: _textController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter text to translate',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//             const SizedBox(height: 16),
            
//             // Translate button
//             ElevatedButton(
//               onPressed: () {
//                 controller.translateText(_textController.text);
//               },
//               child: const Text('Translate to Arabic'),
//             ),
//             const SizedBox(height: 24),
            
//             // Display original and translated text
//             Expanded(
//               child: Obx(() => ListView(
//                 children: [
//                   if (controller.originalText.isNotEmpty) ...[
//                     const Text(
//                       'Original Text:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(controller.originalText.value),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Arabic Translation:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       controller.translatedText.value,
//                       textDirection: TextDirection.rtl,
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ],
//                 ],
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }