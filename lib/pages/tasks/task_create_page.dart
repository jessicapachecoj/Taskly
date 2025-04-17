import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/services/task_service.dart';
import 'package:taskly/models/task_model.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final taskService = TaskService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Descrição"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  final task = TaskModel(
                    id: '', // ID gerado pelo Firestore
                    title: title,
                    description: description,
                  );
                  await taskService.createTask(task);
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos!')),
                  );
                }
              },
              child: const Text("Criar Tarefa"),
            ),
          ],
        ),
      ),
    );
  }
}
