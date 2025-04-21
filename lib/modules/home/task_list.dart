import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/tasks/task_edit.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          child: ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                // Implementar atualização de status
              },
            ),
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: Icon(
                task.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: task.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                // Implementar favorito
              },
            ),
            onTap: () => Get.to(
              AddEditTaskPage(),
              arguments: task,
            ),
          ),
        );
      },
    );
  }
}