import 'package:component/card.dart';
import 'package:component/carousel.dart';
import 'package:component/donut.dart';
import 'package:component/dropdown.dart';
import 'package:component/login.dart';
import 'package:component/pp.dart';
import 'package:component/qq.dart';
import 'package:component/table.dart';
import 'package:component/textfield.dart';
import 'package:component/widgets/custom.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'getwidget.dart';
import 'radio.dart';
import 'progressbar.dart';
import 'pagination.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text("Custom Tile Example")),
        body: PaginationExample(),
      ),
    );
  }
}
