import 'package:get/get.dart';
import 'package:taskly/app/pages/auth/login_page.dart';
import 'package:taskly/app/pages/auth/register_page.dart';
import 'package:taskly/app/pages/tasks/task_list_page.dart';
import 'package:taskly/app/pages/tasks/task_create_page.dart';

class AppPages {
  static const login = '/login';
  static const register = '/register';
  static const taskList = '/task-list';
  static const taskCreate = '/task-create';

  static final routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: taskList, page: () => const TaskListPage()),
    GetPage(name: taskCreate, page: () => const TaskCreatePage()),
  ];
}
