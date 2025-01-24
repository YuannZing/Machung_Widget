import 'package:component/card.dart';
import 'package:component/textfield.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'getwidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Custom Tile Example")),
        body: FieldScreen(),
      ),
    );
  }
}
