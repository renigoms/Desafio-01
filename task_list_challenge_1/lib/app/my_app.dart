import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/pages/task_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
          )),
      debugShowCheckedModeBanner: false,
      home: const TaskPage(),
    );
  }
}
