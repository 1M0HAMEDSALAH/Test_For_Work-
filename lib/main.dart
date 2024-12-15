import 'package:flutter/material.dart';
import 'package:for_test/loding_botton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      home: LoginScreen(),
    );
  }
}
