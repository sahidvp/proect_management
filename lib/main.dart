import 'package:flutter/material.dart';
import 'package:project_management_app/utils/theme/colors.dart';
import 'package:project_management_app/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Project Management',
      theme: ThemeData(
      primaryColor: Appcolors.primary
      ),
      home:HomeScreen(),
    );
  }
}
