import 'package:flutter/material.dart';
import 'package:pocs/ui/constants.dart';
import 'package:pocs/ui/screens/project_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POCs',
      theme: ThemeData(
        primarySwatch: Constants.materialBlackColor,
      ),
      home: const ProjectsList(),
    );
  }
}