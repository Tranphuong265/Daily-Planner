import 'package:flutter/material.dart';

class CustomizableUIScreen extends StatefulWidget {
  @override
  _CustomizableUIScreenState createState() => _CustomizableUIScreenState();
}

class _CustomizableUIScreenState extends State<CustomizableUIScreen> {
  Color _selectedColor = Colors.blue;
  double _selectedFontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tùy chỉnh giao diện'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Chọn màu nền'),
            trailing: DropdownButton<Color>(
              value: _selectedColor,
              items: [
                DropdownMenuItem(
                  child: Text('Xanh dương'),
                  value: Colors.blue,
                ),
                DropdownMenuItem(
                  child: Text('Xanh lá'),
                  value: Colors.green,
                ),
                DropdownMenuItem(
                  child: Text('Đỏ'),
                  value: Colors.red,
                ),
              ],
              onChanged: (Color? value) {
                setState(() {
                  _selectedColor = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Chọn kích thước font'),
            trailing: DropdownButton<double>(
              value: _selectedFontSize,
              items: [
                DropdownMenuItem(
                  child: Text('Nhỏ'),
                  value: 12,
                ),
                DropdownMenuItem(
                  child: Text('Trung bình'),
                  value: 16,
                ),
                DropdownMenuItem(
                  child: Text('Lớn'),
                  value: 20,
                ),
              ],
              onChanged: (double? value) {
                setState(() {
                  _selectedFontSize = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
