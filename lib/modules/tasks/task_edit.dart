import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/task_controller.dart';

class AddEditTaskPage extends StatelessWidget {
  final TaskController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final Task? task = Get.arguments;

    if (task != null) {
      _titleController.text = task.title;
      _descriptionController.text = task.description;
      _selectedDate = task.createdAt;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Adicionar Tarefa' : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Selecionar Data'
                      : 'Data: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: task?.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      userId: Get.find<AuthService>().user!.uid,
                      createdAt: _selectedDate ?? DateTime.now(),
                      isCompleted: task?.isCompleted ?? false,
                      isFavorite: task?.isFavorite ?? false,
                    );

                    if (task == null) {
                      _controller.addTask(newTask);
                    } else {
                      _controller.updateTask(newTask);
                    }
                    Get.back();
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    await Get.dialog(
      AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: SfDateRangePicker(
            initialDate: _selectedDate ?? DateTime.now(),
            onSelectionChanged: (DateRangePickerSelectionArgs args) {
              if (args.value is DateTime) {
                _selectedDate = args.value;
                Get.back();
              }
            },
          ),
        ),
      ),
    );
  }
}