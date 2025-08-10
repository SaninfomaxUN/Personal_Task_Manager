import 'package:flutter/material.dart';

import '../widgets/task_form.dart';


class UpdateTaskPage extends StatelessWidget {
  final int taskId;

  const UpdateTaskPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(
          isUpdateMode: true,
          onTaskCalled: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          taskId: taskId,
        ),
      ),
    );
  }
}