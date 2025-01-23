import 'package:flutter/material.dart';

class TaskNotFound extends StatelessWidget {
  const TaskNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.close,
          color: Colors.red,
          size: 200,
        ),
        Text(
          "Without Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
