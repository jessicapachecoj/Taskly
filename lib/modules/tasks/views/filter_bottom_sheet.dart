import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/modules/tasks/task_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  final TaskController _taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filtrar Tarefas', style: Get.textTheme.titleLarge),
          Divider(),
          Obx(() => SwitchListTile(
                title: Text('Mostrar Concluídas'),
                value: _taskController.showCompleted.value,
                onChanged: (value) => _taskController.toggleShowCompleted(),
              )),
          Obx(() => SwitchListTile(
                title: Text('Mostrar Favoritas'),
                value: _taskController.showFavorites.value,
                onChanged: (value) => _taskController.toggleShowFavorites(),
              )),
          SizedBox(height: 16),
          Text('Ordenar por', style: Get.textTheme.titleMedium),
          Obx(() => Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Data'),
                    value: 'date',
                    groupValue: _taskController.sortBy.value,
                    onChanged: (value) => _taskController.setSortBy(value!),
                  ),
                  RadioListTile<String>(
                    title: Text('Título'),
                    value: 'title',
                    groupValue: _taskController.sortBy.value,
                    onChanged: (value) => _taskController.setSortBy(value!),
                  ),
                ],
              )),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text('Aplicar Filtros'),
          ),
        ],
      ),
    );
  }
}