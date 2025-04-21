import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/modules/tasks/task_controller.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final TaskController _taskController = Get.find<TaskController>(); 
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Obx(() {
          return Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              _taskController.toggleTaskCompletion(task);
            },
          );
        }),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            SizedBox(height: 4),
            Text(
              'Criada em: ${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Obx(() {
          return IconButton(
            icon: Icon(
              task.isFavorite ? Icons.star : Icons.star_border,
              color: task.isFavorite ? Colors.amber : null,
            ),
            onPressed: () {
              _taskController.toggleTaskFavorite(task);
            },
          );
        }),
        onTap: () => Get.toNamed('/edit-task', arguments: task),
      ),
    );
  }
}