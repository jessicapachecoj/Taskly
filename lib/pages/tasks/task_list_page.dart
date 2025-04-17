import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/services/task_service.dart';
import 'package:taskly/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskly/models/task_model.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskService = TaskService();

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(
            child: ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              child: const Text("Faça login para acessar as tarefas"),
            ),
          );
        }

        // Usuário autenticado, mostrar lista de tarefas
        return Scaffold(
          appBar: AppBar(title: const Text("Lista de Tarefas")),
          body: StreamBuilder<List<TaskModel>>(
            stream: taskService.getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final tasks = snapshot.data ?? [];

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        taskService.deleteTask(task.id);
                      },
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.taskCreate);
                    },
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.taskCreate);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
