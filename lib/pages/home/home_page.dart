import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.to.logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo ao Taskly!'),
      ),
    );
  }
}
