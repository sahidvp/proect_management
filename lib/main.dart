import 'package:flutter/material.dart';
import 'package:project_management_app/controller/form_controller.dart';
import 'package:project_management_app/controller/news_provder.dart';
import 'package:project_management_app/utils/theme/colors.dart';
import 'package:project_management_app/view/form_screen/form_screen.dart';
import 'package:project_management_app/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()..fetchProjects()),
        ChangeNotifierProvider(create: (_) => NewsProvider()..fetchNews()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Management',
      theme: ThemeData(
          primaryColor: Appcolors.primary,
          scaffoldBackgroundColor: Appcolors.background),
      home: HomeScreen(),
      routes: {
        "/home": (context) => HomeScreen(),
        "/form": (context) => FormScreen()
      },
    );
  }
}
