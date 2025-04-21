import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/services/auth_service.dart';
import 'package:taskly/routes/app_pages.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();  
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Registrar")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,  
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Validação de campos
                if (nameController.text.isEmpty || 
                    emailController.text.isEmpty || 
                    passwordController.text.isEmpty) {
                  Get.snackbar("Erro", "Por favor, preencha todos os campos.");
                  return;
                }

                // Exibir indicador de carregamento
                Get.dialog(
                  const Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                // Registrar usuário
                final result = await AuthService.to.register(
                  nameController.text,  
                  emailController.text,
                  passwordController.text,
                );

                // Fechar o indicador de carregamento
                Get.back();

                // Feedback de sucesso ou erro
                if (result != null) {
                  Get.snackbar("Sucesso", "Registro realizado com sucesso!");
                  Get.offAllNamed(AppRoutes.login);
                } else {
                  Get.snackbar("Erro", "Erro ao registrar, tente novamente.");
                }
              },
              child: const Text("Criar Conta"),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Voltar"),
            ),
          ],
        ),
      ),
    );
  }
}
