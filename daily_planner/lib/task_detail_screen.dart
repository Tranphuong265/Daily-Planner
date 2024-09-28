import 'package:daily_planner/edit_task_screen.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> taskData; // Dữ liệu công việc

  TaskDetailScreen({
    required this.taskData,
  });
  
  get taskIndex => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết Công việc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nội dung: ${taskData['content']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Địa điểm: ${taskData['location']}'),
            SizedBox(height: 10),
            Text('Ghi chú: ${taskData['notes']}'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Chuyển đến màn hình chỉnh sửa công việc
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskScreen(
                        taskData: taskData, // Truyền dữ liệu công việc
                        taskIndex: taskIndex, task: {}, // Truyền taskIndex
                      ),
                    ),
                  );
                },
                child: Text('Chỉnh sửa công việc'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
