import 'package:daily_planner/home_screen.dart';
import 'package:daily_planner/on_boarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoarding(), 
    );
  }
}
