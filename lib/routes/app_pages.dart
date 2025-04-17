import 'package:get/get.dart';
import 'package:taskly/pages/auth/login_page.dart';
import 'package:taskly/pages/auth/register_page.dart';
import 'package:taskly/pages/tasks/task_list_page.dart';
import 'package:taskly/pages/tasks/task_create_page.dart';

abstract class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const taskList = '/task-list';
  static const taskCreate = '/task-create';
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.taskList, page: () => const TaskListPage()),
    GetPage(name: AppRoutes.taskCreate, page: () => const TaskCreatePage()),
  ];
}
