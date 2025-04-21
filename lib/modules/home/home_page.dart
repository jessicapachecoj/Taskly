import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/modules/tasks/task_controller.dart';
import 'package:taskly/widgets/task_list.dart';

class HomePage extends StatelessWidget {
  final TaskController _controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => AppTheme.changeTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Get.find<AuthService>().logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.tasks.isEmpty) {
          return const Center(child: Text('Nenhuma tarefa encontrada'));
        }
        return TaskList(tasks: _controller.tasks);
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed('/add_task'),
      ),
    );
  }

  void _showSearchDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Buscar tarefas'),
        content: TextField(
          onChanged: (value) {
            _controller.searchQuery.value = value;
            _controller._applyFilters();
          },
          decoration: const InputDecoration(hintText: 'Digite para buscar'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Filtrar e ordenar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filtrar por:'),
            Obx(() => Column(
              children: [
                RadioListTile(
                  title: const Text('Todas'),
                  value: 'all',
                  groupValue: _controller.filter.value,
                  onChanged: (value) {
                    _controller.filter.value = value.toString();
                    _controller._applyFilters();
                  },
                ),
                RadioListTile(
                  title: const Text('Concluídas'),
                  value: 'completed',
                  groupValue: _controller.filter.value,
                  onChanged: (value) {
                    _controller.filter.value = value.toString();
                    _controller._applyFilters();
                  },
                ),
                RadioListTile(
                  title: const Text('Favoritas'),
                  value: 'favorite',
                  groupValue: _controller.filter.value,
                  onChanged: (value) {
                    _controller.filter.value = value.toString();
                    _controller._applyFilters();
                  },
                ),
              ],
            )),
            const Divider(),
            const Text('Ordenar por:'),
            Obx(() => Column(
              children: [
                RadioListTile(
                  title: const Text('Data'),
                  value: 'date',
                  groupValue: _controller.sortBy.value,
                  onChanged: (value) {
                    _controller.sortBy.value = value.toString();
                    _controller._applyFilters();
                  },
                ),
                RadioListTile(
                  title: const Text('Nome'),
                  value: 'title',
                  groupValue: _controller.sortBy.value,
                  onChanged: (value) {
                    _controller.sortBy.value = value.toString();
                    _controller._applyFilters();
                  },
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}