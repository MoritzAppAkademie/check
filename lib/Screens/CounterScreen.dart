import 'package:flutter/material.dart';
import '../widgets/TaskCounterCard.dart';

class CounterScreen extends StatelessWidget {
  final int taskCount;

  const CounterScreen({Key? key, required this.taskCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            TaskCounterCard(taskCount: taskCount),
          ],
        ),
      ),
    );
  }
}
