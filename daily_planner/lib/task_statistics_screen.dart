import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Thống kê công việc')),
      body: SingleChildScrollView(
        // Thêm SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Thống kê công việc', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: 40,
                      title: 'Hoàn thành',
                      radius: 50,
                      titleStyle: TextStyle(fontSize: 16),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: 30,
                      title: 'Đang thực hiện',
                      radius: 50,
                      titleStyle: TextStyle(fontSize: 16),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: 30,
                      title: 'Chưa bắt đầu',
                      radius: 50,
                      titleStyle: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Có thể thêm nhiều nội dung nếu cần
            ],
          ),
        ),
      ),
    );
  }
}
