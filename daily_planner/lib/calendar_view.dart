import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_task_screen.dart'; // Nhập khẩu AddTaskScreen

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Danh sách nhiệm vụ
  Map<DateTime, List<Map<String, dynamic>>> tasks = {
    DateTime.now(): [{'content': 'Task 1'}, {'content': 'Task 2'}],
    DateTime.now().add(Duration(days: 1)): [{'content': 'Task 3'}],
  };

  void _addTask(Map<String, dynamic> task) {
    setState(() {
      DateTime taskDate = task['date'];
      if (tasks[taskDate] != null) {
        tasks[taskDate]!.add(task); // Thêm nhiệm vụ vào ngày cụ thể
      } else {
        tasks[taskDate] = [task]; // Tạo mới danh sách nhiệm vụ cho ngày này
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch Công việc'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Mở màn hình thêm công việc
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ),
              );

              // Nếu có dữ liệu nhiệm vụ mới, thêm vào danh sách
              if (newTask != null) {
                _addTask(newTask);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) => tasks[day]?.map((task) => task['content']).toList() ?? [],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Nhiệm vụ hôm nay: ${tasks[_selectedDay]?.map((task) => task['content']).join(', ') ?? 'Không có nhiệm vụ'}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
