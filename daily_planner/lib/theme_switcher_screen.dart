import 'package:flutter/material.dart';

class ThemeSwitcherScreen extends StatefulWidget {
  @override
  _ThemeSwitcherScreenState createState() => _ThemeSwitcherScreenState();
}

class _ThemeSwitcherScreenState extends State<ThemeSwitcherScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chủ đề Tối/Sáng'),
        ),
        body: Center(
          child: SwitchListTile(
            title: Text('Chế độ Tối'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
