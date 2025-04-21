import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/modules/tasks/views/task_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text('Nenhuma tarefa encontrada'),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskItem(task: task);
      },
    );
  }
}