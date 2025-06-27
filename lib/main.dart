import 'package:crash_course/pages/home_page.dart';
import 'package:crash_course/provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDetailProvider>(
      create: (context) => UserDetailProvider(),
      child: MaterialApp(theme: ThemeData.light(), home: HomePage()),
    );
  }
}
