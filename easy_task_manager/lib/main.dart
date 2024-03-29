import 'package:easy_task_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Easy Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
