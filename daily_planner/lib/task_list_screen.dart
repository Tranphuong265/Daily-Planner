import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Danh sách công việc
  List<Map<String, dynamic>> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách công việc'),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text('Chưa có công việc nào.'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['content']),
                  subtitle: Text(
                    'Ngày: ${task['date']?.day}/${task['date']?.month}/${task['date']?.year}, '
                    'Địa điểm: ${task['location']}, '
                    'Chủ trì: ${task['leader']}',
                  ), // Hiển thị thêm thông tin
                  onTap: () {
                    _showTaskDialog(context, task, index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask); // Thêm công việc mới vào danh sách
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

void _showTaskDialog(BuildContext context, Map<String, dynamic> task, int index) {
  // Lưu BuildContext của widget cha
  final parentContext = context;

  showDialog(
    context: parentContext, // Sử dụng context của widget cha
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(task['content']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Ngày: ${task['date']?.day}/${task['date']?.month}/${task['date']?.year}'),
            Text('Địa điểm: ${task['location']}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDialogButton(Icons.delete, 'Delete', () {
                  setState(() {
                    tasks.removeAt(index); // Xóa công việc
                  });
                  Navigator.of(context).pop();
                }),
                _buildDialogButton(Icons.copy, 'Duplicate', () {
                  setState(() {
                    tasks.add({
                      'content': '${task['content']} (Copy)',
                      'date': task['date'],
                      'location': task['location'],
                      'leader': task['leader'],
                    });
                  });
                  Navigator.of(context).pop();
                }),
                _buildDialogButton(Icons.check_circle, 'Complete', () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Edit Task'),
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng dialog trước khi chỉnh sửa
                final updatedTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      taskData: task,
                      task: task,
                      taskIndex: index,
                    ),
                  ),
                );
                if (updatedTask != null) {
                  setState(() {
                    tasks[index] = updatedTask; // Cập nhật công việc với thông tin mới
                  });
                  // Hiển thị lại dialog với thông tin đã cập nhật
                  _showTaskDialog(parentContext, tasks[index], index); // Sử dụng parentContext
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

  Widget _buildDialogButton(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.redAccent),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
