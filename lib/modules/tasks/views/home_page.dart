import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/modules/tasks/task_controller.dart';
import 'package:taskly/modules/tasks/views/add_task_page.dart';
import 'package:taskly/modules/tasks/views/task_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: Obx(() => TaskList(tasks: _taskController.filteredTasks)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTaskPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
