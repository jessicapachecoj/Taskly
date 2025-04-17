import 'package:get/get.dart';
import 'package:taskly/pages/auth/login_page.dart';
import 'package:taskly/pages/auth/register_page.dart';
import 'package:taskly/pages/home/home_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}

class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
  ];
}
