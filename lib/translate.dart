// import 'package:flutter/material.dart';
// import 'package:for_test/controller.dart';
// import 'package:for_test/extenstion.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TranslationExtension.tr("محمد صلاح"),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: TranslationExtension.tr(
//                 'Settings',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.language),
//               title: TranslationExtension.tr('Select Language'),
//               onTap: () => _showLanguageSelectionDialog(context),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: TranslationExtension.tr(
//           'Welcome to our app',
//           style: TextStyle(fontSize: 20),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }

//   void _showLanguageSelectionDialog(BuildContext context) {
//     final Map<String, String> allLanguages = {
//       'en': 'English',
//       'ar': 'العربية',
//       'fr': 'Français',
//       'es': 'Español',
//       'de': 'Deutsch',
//       'hi': 'हिंदी',
//       'zh': '中文',
//       'ru': 'Русский',
//       'ja': '日本語',
//       'pt': 'Português',
//       'it': 'Italiano',
//       'ko': '한국어',
//       'tr': 'Türkçe',
//       'id': 'Bahasa Indonesia',
//       'th': 'ไทย',
//       'vi': 'Tiếng Việt',
//       'ms': 'Bahasa Melayu',
//       'pl': 'Polski',
//       'uk': 'Українська',
//       'sv': 'Svenska',
//       'no': 'Norsk',
//       'da': 'Dansk',
//       'fi': 'Suomi',
//       'nl': 'Nederlands',
//       'cs': 'Čeština',
//       'el': 'Ελληνικά',
//       'hu': 'Magyar',
//       'ro': 'Română',
//       'fa': 'فارسی',
//       'ur': 'اردو',
//       'ta': 'தமிழ்',
//       'te': 'తెలుగు',
//       'bn': 'বাংলা',
//       'pa': 'ਪੰਜਾਬੀ',
//       'gu': 'ગુજરાતી',
//       'mr': 'मराठी',
//       'kn': 'ಕನ್ನಡ',
//       'ml': 'മലയാളം',
//       'si': 'සිංහල',
//       'am': 'አማርኛ',
//       'sw': 'Kiswahili',
//       'ha': 'Hausa',
//       'yo': 'Yorùbá',
//       'ig': 'Igbo',
//       'zu': 'IsiZulu',
//       'af': 'Afrikaans',
//       'eu': 'Euskara',
//       'gl': 'Galego',
//       'ca': 'Català',
//       'ga': 'Gaeilge',
//       'is': 'Íslenska',
//       'mt': 'Malti',
//       'cy': 'Cymraeg',
//       'lv': 'Latviešu',
//       'lt': 'Lietuvių',
//       'et': 'Eesti',
//       'sq': 'Shqip',
//       'mk': 'Македонски',
//       'sr': 'Српски',
//       'hr': 'Hrvatski',
//       'sl': 'Slovenščina',
//       'sk': 'Slovenčina',
//       'bg': 'Български',
//       'he': 'עברית',
//       'ka': 'ქართული',
//       'hy': 'Հայերեն',
//       'az': 'Azərbaycan',
//       'kk': 'Қазақ',
//       'uz': 'Oʻzbek',
//       'ky': 'Кыргызча',
//       'tg': 'Тоҷикӣ',
//       'tk': 'Türkmen',
//       'mn': 'Монгол',
//       'lo': 'ລາວ',
//       'my': 'မြန်မာ',
//       'km': 'ខ្មែរ',
//       'la': 'Latina',
//     };

//     Get.dialog(
//       AlertDialog(
//         title: TranslationExtension.tr('Choose Language'),
//         content: Container(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: allLanguages.length,
//             itemBuilder: (context, index) {
//               final langCode = allLanguages.keys.elementAt(index);
//               final langName = allLanguages[langCode]!;
//               return ListTile(
//                 title: Text(langName),
//                 onTap: () {
//                   TranslationController.to.changeLanguage(langCode);
//                   Get.back();
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
