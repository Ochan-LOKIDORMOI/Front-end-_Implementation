import 'package:flutter/material.dart';
// import 'package:implementation/profile_screen.dart';
import 'package:implementation/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discove_Rwanda',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.teal[100],
      ),
      home: HomePage(),
    );
  }
}
