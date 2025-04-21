import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taskly/core/constants/app_constants.dart';
import 'package:taskly/data/models/task_model.dart';  

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> getTasks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(AppConstants.tasksCollection)  
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();  
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks');
      return [];
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _firestore
          .collection(AppConstants.tasksCollection)
          .add(task.toMap());  // Certifique-se de que 'toMap' está corretamente implementado
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _firestore
          .collection(AppConstants.tasksCollection)
          .doc(task.id)
          .update(task.toMap());
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore
          .collection(AppConstants.tasksCollection)
          .doc(taskId)
          .delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  Future<List<Task>> searchTasks(String query, String userId) async {
    try {
      final snapshot = await _firestore
          .collection(AppConstants.tasksCollection)
          .where('userId', isEqualTo: userId)
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: query + 'z')
          .get();

      return snapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to search tasks');
      return [];
    }
  }
}
