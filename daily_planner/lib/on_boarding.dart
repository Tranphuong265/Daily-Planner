import 'package:daily_planner/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 25), 
            const Text(
              'Welcom to Daily Planner',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80), 
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 20), // Điều chỉnh padding
                textStyle: const TextStyle(fontSize: 20), // Điều chỉnh kích thước chữ
                minimumSize: const Size(
                    200, 50), // Kích thước tối thiểu cho nút (rộng, cao)
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
