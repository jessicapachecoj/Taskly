import 'package:flutter/material.dart';
import 'package:taskly/core/utils/validators.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final bool showNameField;

  const AuthForm({
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.showNameField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showNameField)
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
              prefixIcon: Icon(Icons.person),
            ),
            validator: AppValidators.validateName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
        if (showNameField) SizedBox(height: 16),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          validator: AppValidators.validateEmail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Senha',
            prefixIcon: Icon(Icons.lock),
          ),
          validator: AppValidators.validatePassword,
          obscureText: true,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}