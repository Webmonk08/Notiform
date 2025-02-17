import 'package:flutter/material.dart';
import 'login_signup_page.dart';
//import 'student_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Fix: Ensures proper Flutter initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Room Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginSignupPage(), // Start with Login/Signup Page
    );
  }
}















