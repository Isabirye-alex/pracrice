import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'demo/object_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ObjectWidget(),
    );
  }
}

class Alex extends StatefulWidget {
  const Alex({super.key});

  @override
  State<Alex> createState() => _AlexState();
}

class _AlexState extends State<Alex> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


