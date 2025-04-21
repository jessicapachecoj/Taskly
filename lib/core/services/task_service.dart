import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskly/core/constants/app_constants.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      await _firestore.collection(AppConstants.tasksCollection).add(taskData);
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Stream<QuerySnapshot> getTasksStream(String userId) {
    return _firestore
        .collection(AppConstants.tasksCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection(AppConstants.tasksCollection)
          .doc(taskId)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore
          .collection(AppConstants.tasksCollection)
          .doc(taskId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}