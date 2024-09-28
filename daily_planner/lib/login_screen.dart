import 'package:daily_planner/home_screen.dart';
import 'package:daily_planner/task_manager.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Trường email
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 70, 0, 150)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập email';
                          }
                          email = value;
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Trường mật khẩu
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 92, 0, 150)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          labelStyle: TextStyle(fontSize: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          password = value;
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Giả lập đăng nhập thành công, điều hướng đến TaskManager
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      child: Text('Đăng nhập', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
