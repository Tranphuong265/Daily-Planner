import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Controllers and variables
  TextEditingController _contentController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedLeader;
  String? _approvalStatus = 'Tạo mới';
  String? _approver;

  List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa'];
  List<String> _approvalStatuses = ['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc'];

  // Select Date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Select Time
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Công việc mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chọn ngày
              ListTile(
                title: Text('Chọn ngày:'),
                subtitle: Text(_selectedDate != null
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'Chưa chọn ngày'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 16),

              // Chọn thời gian bắt đầu và kết thúc
              ListTile(
                title: Text('Thời gian bắt đầu:'),
                subtitle: Text(_startTime != null ? _startTime!.format(context) : 'Chưa chọn thời gian'),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context, true),
              ),
              ListTile(
                title: Text('Thời gian kết thúc:'),
                subtitle: Text(_endTime != null ? _endTime!.format(context) : 'Chưa chọn thời gian'),
                trailing: Icon(Icons.access_time),
                onTap: () => _selectTime(context, false),
              ),
              SizedBox(height: 16),

              // Nội dung công việc
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Nội dung công việc',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Địa điểm
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Địa điểm',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Chủ trì (Dropdown)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Chủ trì',
                  border: OutlineInputBorder(),
                ),
                value: _selectedLeader,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLeader = newValue;
                  });
                },
                items: _leaders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Ghi chú
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Ghi chú',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Trạng thái kiểm duyệt (Dropdown)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Trạng thái kiểm duyệt',
                  border: OutlineInputBorder(),
                ),
                value: _approvalStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _approvalStatus = newValue;
                  });
                },
                items: _approvalStatuses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Người kiểm duyệt
              TextField(
                decoration: InputDecoration(
                  labelText: 'Người kiểm duyệt',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _approver = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Nút Lưu công việc
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý thêm công việc mới
                    if (_selectedDate != null &&
                        _startTime != null &&
                        _endTime != null &&
                        _contentController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        _selectedLeader != null &&
                        _approver != null) {
                      // Trả về dữ liệu công việc mới
                      Navigator.pop(context, {
                        'date': _selectedDate,
                        'startTime': _startTime,
                        'endTime': _endTime,
                        'content': _contentController.text,
                        'location': _locationController.text,
                        'leader': _selectedLeader,
                        'notes': _notesController.text,
                        'approvalStatus': _approvalStatus,
                        'approver': _approver,
                      });
                    } else {
                      // Hiển thị cảnh báo nếu còn thiếu thông tin
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
                      );
                    }
                  },
                  child: Text('Lưu công việc'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}