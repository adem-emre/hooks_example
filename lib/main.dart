import 'package:flutter/material.dart';
import 'package:hooks_example/examples/fetch_data/fetch_data_example.dart';


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
      home: const FetchDataExample(),
    );
  }
}
