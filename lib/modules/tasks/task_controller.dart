import 'package:get/get.dart';
import 'package:taskly:data/models/task_model.dart';
import 'package:taskly:data/repositories/task_repository.dart';

class TaskController extends GetxController {
  final TaskRepository _repository = Get.find();
  final RxList<Task> tasks = <Task>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString filter = 'all'.obs; 
  final RxString sortBy = 'date'.obs; 

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  Future<void> loadTasks() async {
    final user = Get.find<AuthService>().user;
    if (user != null) {
      final taskList = await _repository.getTasks(user.uid);
      tasks.assignAll(taskList);
      _applyFilters();
    }
  }

  void _applyFilters() {
    var filteredTasks = tasks.where((task) {
      final matchesSearch = task.title.toLowerCase().contains(searchQuery.value.toLowerCase()) || 
                           task.description.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      final matchesFilter = filter.value == 'all' || 
                          (filter.value == 'completed' && task.isCompleted) ||
                          (filter.value == 'favorite' && task.isFavorite);
      
      return matchesSearch && matchesFilter;
    }).toList();

    if (sortBy.value == 'date') {
      filteredTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      filteredTasks.sort((a, b) => a.title.compareTo(b.title));
    }

    tasks.assignAll(filteredTasks);
  }

}