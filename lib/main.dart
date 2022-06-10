import 'package:flutter/material.dart';
import 'package:hooks_example/examples/image_load/image_load_example.dart';
import 'package:hooks_example/examples/listenable_count_down/listenable_count_down_example.dart';
import 'package:hooks_example/examples/reducer/reducer_exampe.dart';

import 'examples/text_controller/text_controller_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReducerExample(),
    );
  }
}
