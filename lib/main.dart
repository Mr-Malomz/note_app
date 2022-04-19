import 'package:flutter/material.dart';
import 'package:note_app/screens/home.dart';

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
          // primarySwatch: Color.fromARGB(222, 28, 140, 1),
          ),
      home: const Home(),
    );
  }
}
