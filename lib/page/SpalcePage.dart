import 'dart:async';
import 'HomePage.dart';
import 'WelcomePage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Color backgroundColor = Color(0xFF00CA44); // Màu ban đầu #00CA44
  String imagePath = 'assets/images/logo_with_character.png'; // Hình ban đầu

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        backgroundColor = Color(0xFF019934); // Chuyển màu ngay lập tức
      });
      // Đợi 1 frame để màu áp dụng, rồi đổi hình
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          imagePath = 'assets/images/logo_with_character_loading.png'; // Đổi hình
        });
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Thay AnimatedContainer bằng Container để đổi màu ngay lập tức
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}