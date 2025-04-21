import 'package:get/get.dart';
import 'package:taskly/data/repositories/task_repository.dart';
import 'package:taskly/modules/tasks/task_controller.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    // Registrando o TaskRepository
    Get.lazyPut<TaskRepository>(() => TaskRepository());
    
    // Registrando o TaskController, passando o TaskRepository como parâmetro
    Get.lazyPut<TaskController>(() => TaskController(taskRepository: Get.find()), fenix: true);
  }
}
