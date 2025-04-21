import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/data/repositories/task_repository.dart';

class TaskController extends GetxController {
  final TaskRepository taskRepository;
  final RxList<Task> tasks = <Task>[].obs;
  final RxList<Task> filteredTasks = <Task>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool showCompleted = false.obs;
  final RxBool showFavorites = false.obs;
  final RxString sortBy = 'date'.obs;
  final RxBool isLoading = false.obs;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  TaskController({required this.taskRepository});

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final tasksList = await taskRepository.getTasks(userId);
      tasks.assignAll(tasksList);
      _applyFilters();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await taskRepository.addTask(task);
      await fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await taskRepository.updateTask(task);
      await fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await taskRepository.deleteTask(taskId);
      await fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  void toggleTaskCompletion(Task task) {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    updateTask(updatedTask);
  }

  void toggleTaskFavorite(Task task) {
    final updatedTask = task.copyWith(isFavorite: !task.isFavorite);
    updateTask(updatedTask);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void toggleShowCompleted() {
    showCompleted.toggle();
    _applyFilters();
  }

  void toggleShowFavorites() {
    showFavorites.toggle();
    _applyFilters();
  }

  void setSortBy(String value) {
    sortBy.value = value;
    _applyFilters();
  }

  void _applyFilters() {
    filteredTasks.assignAll(tasks.where((task) {
      final matchesSearch = searchQuery.isEmpty ||
          task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCompletion = showCompleted.value ? true : !task.isCompleted;
      final matchesFavorite = showFavorites.value ? task.isFavorite : true;

      return matchesSearch && matchesCompletion && matchesFavorite;
    }));

    _sortTasks();
  }

  void _sortTasks() {
    filteredTasks.sort((a, b) {
      if (sortBy.value == 'date') {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return a.title.compareTo(b.title);
      }
    });
  }
}
