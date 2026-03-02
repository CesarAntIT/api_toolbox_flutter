import 'package:api_toolbox_t6/pages/main_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("API Toolbox!!", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
        body: MainMenu(),
      ),
    );
  }
}
