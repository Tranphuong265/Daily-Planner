import 'package:flutter/material.dart';

class DragDropScreen extends StatefulWidget {
  @override
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  List<String> _tasks = ['Task 1', 'Task 2', 'Task 3', 'Task 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kéo thả danh sách công việc'),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = _tasks.removeAt(oldIndex);
            _tasks.insert(newIndex, item);
          });
        },
        children: _tasks.map((task) {
          return ListTile(
            key: ValueKey(task),
            title: Text(task),
          );
        }).toList(),
      ),
    );
  }
}
