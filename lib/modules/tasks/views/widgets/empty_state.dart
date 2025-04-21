import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    this.message = 'Nenhuma tarefa encontrada',
    this.icon = Icons.assignment_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Get.theme.disabledColor),
          SizedBox(height: 16),
          Text(
            message,
            style: Get.textTheme.subtitle1?.copyWith(
              color: Get.theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}