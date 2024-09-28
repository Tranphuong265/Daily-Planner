import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskReminderScreen extends StatefulWidget {
  @override
  _TaskReminderScreenState createState() => _TaskReminderScreenState();
}

class _TaskReminderScreenState extends State<TaskReminderScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      // 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Nhắc nhở công việc',
      'Đã đến giờ làm công việc',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo nhiệm vụ'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showNotification,
          child: Text('Cài đặt thông báo'),
        ),
      ),
    );
  }
}
