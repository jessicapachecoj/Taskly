import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/modules/tasks/task_controller.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final TaskController _taskController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor, insira um título' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: '', // O ID será gerado depois no banco de dados
                      title: _titleController.text,
                      description: _descriptionController.text,
                      createdAt: DateTime.now(),
                      userId: _taskController.userId,
                    );
                    _taskController.addTask(newTask);
                    Get.back();
                  }
                },
                child: const Text('Adicionar Tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
