import 'package:get/get.dart';
import 'package:taskly/core/bindings/auth_binding.dart';
import 'package:taskly/core/bindings/task_binding.dart';
import 'package:taskly/modules/auth/views/login_page.dart';
import 'package:taskly/modules/auth/views/signup_page.dart';
import 'package:taskly/modules/tasks/views/add_task_page.dart';
import 'package:taskly/modules/tasks/views/edit_task_page.dart';
import 'package:taskly/modules/tasks/views/home_page.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const ADD_TASK = '/add-task';
  static const EDIT_TASK = '/edit-task';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(), 
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupPage(), 
      
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: Routes.ADD_TASK,
      page: () => AddTaskPage(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: Routes.EDIT_TASK,
      page: () => EditTaskPage(task: Get.arguments),
      binding: TaskBinding(),
    ),
  ];
}
