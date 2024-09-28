import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  final Map<String, dynamic> taskData; // Nhận dữ liệu công việc từ màn hình trước

  EditTaskScreen({required this.taskData, Key? key, required Map<String, dynamic> task, required int taskIndex}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  // Controllers and variables
  late TextEditingController _contentController;
  late TextEditingController _locationController;
  late TextEditingController _notesController;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedLeader;
  String? _approvalStatus;
  String? _approver;

  List<String> _leaders = ['Thanh Ngân', 'Hữu Nghĩa'];
  List<String> _approvalStatuses = ['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc'];

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với giá trị hiện có
    _contentController = TextEditingController(text: widget.taskData['content']);
    _locationController = TextEditingController(text: widget.taskData['location']);
    _notesController = TextEditingController(text: widget.taskData['notes']);
    _selectedDate = widget.taskData['date'];
    _startTime = widget.taskData['startTime'];
    _endTime = widget.taskData['endTime'];
    _selectedLeader = widget.taskData['leader'];
    _approvalStatus = widget.taskData['approvalStatus'];
    _approver = widget.taskData['approver'];
  }

  @override
  void dispose() {
    // Giải phóng các controller khi không còn sử dụng
    _contentController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // Select Date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
      initialTime: isStartTime ? (_startTime ?? TimeOfDay.now()) : (_endTime ?? TimeOfDay.now()),
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
        title: Text('Chỉnh sửa Công việc'),
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
                    // Xử lý chỉnh sửa công việc
                    if (_selectedDate != null &&
                        _startTime != null &&
                        _endTime != null &&
                        _contentController.text.isNotEmpty &&
                        _locationController.text.isNotEmpty &&
                        _selectedLeader != null &&
                        _approver != null) {
                      // Trả về dữ liệu công việc đã chỉnh sửa
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
