// import 'package:flutter/material.dart';
// import 'package:for_test/controller.dart';
// import 'package:for_test/translate.dart';
// import 'package:get/get.dart';

// extension TranslationExtension on Text {
//   static Widget tr(
//     String text, {
//     Key? key,
//     TextStyle? style,
//     TextAlign? textAlign,
//     TextOverflow? overflow,
//     int? maxLines,
//   }) {
//     return GetBuilder<TranslationController>(
//       builder: (controller) => FutureBuilder<String>(
//         future: controller.translateText(text),
//         initialData: text,
//         builder: (context, snapshot) {
//           return Text(
//             snapshot.data ?? text,
//             key: key,
//             style: style,
//             textAlign: textAlign,
//             overflow: overflow,
//             maxLines: maxLines,
//           );
//         },
//       ),
//     );
//   }
// }
