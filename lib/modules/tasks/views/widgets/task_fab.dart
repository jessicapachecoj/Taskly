import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/modules/tasks/views/add_task_page.dart';

class TaskFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Get.to(() => AddTaskPage()),
      tooltip: 'Adicionar Tarefa',
    );
  }
}