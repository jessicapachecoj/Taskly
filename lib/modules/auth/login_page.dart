import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/services/auth_service.dart';
import 'package:taskly/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo para o email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            // Campo para a senha
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Verificar se os campos estão preenchidos
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  Get.snackbar("Erro", "Preencha todos os campos!");
                  return;
                }

                // Exibir indicador de carregamento
                Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

                // Tentar fazer o login
                final result = await AuthService.to.login(
                  emailController.text,
                  passwordController.text,
                );

                // Fechar o indicador de carregamento
                Get.back();

                if (result != null) {
                  Get.snackbar("Sucesso", "Login realizado com sucesso");
                  Get.offAllNamed(AppRoutes.taskList); // Navegar para a lista de tarefas
                } else {
                  Get.snackbar("Erro", "Erro ao fazer login.");
                }
              },
              child: const Text("Entrar"),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.register),
              child: const Text("Criar conta"),
            ),
          ],
        ),
      ),
    );
  }
}
