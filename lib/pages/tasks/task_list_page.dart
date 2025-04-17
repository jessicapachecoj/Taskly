import 'package:flutter/material.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Tarefas")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar para a página de criação de tarefa
          },
          child: const Text("Criar nova tarefa"),
        ),
      ),
    );
  }
}
