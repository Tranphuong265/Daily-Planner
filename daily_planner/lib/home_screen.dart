import 'package:flutter/material.dart';
import 'task_list_screen.dart'; // Bài 1: Danh sách công việc
import 'calendar_view.dart'; // Bài 2: Màn hình lịch
import 'task_statistics_screen.dart'; // Bài 3: Thống kê công việc

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TaskListScreen(), // Màn hình từ Bài 1: Danh sách công việc
    CalendarView(), // Màn hình từ Bài 2: Lịch
    TaskStatisticsScreen(), // Màn hình từ Bài 3: Thống kê công việc
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Daily Planner')),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Công việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
