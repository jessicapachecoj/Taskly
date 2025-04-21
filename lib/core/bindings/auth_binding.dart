import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/data/repositories/auth_repository.dart';
import 'package:taskly/modules/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Registrando o AuthRepository e GetStorage
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => GetStorage());
    
    // Registrando o AuthController, passando as dependências injetadas
    Get.lazyPut(() => AuthController(
      authRepository: Get.find(),
      storage: Get.find(),
    ));
  }
}
