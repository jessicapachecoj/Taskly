import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:/taskly/models/task_model.dart';
import 'package:/taskly/core/services/local_storage_service.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalStorageService _localStorage = Get.find();

  Future<List<Task>> getTasks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();
          
      return snapshot.docs.map((doc) {
        return Task.fromMap({'id': doc.id, ...doc.data()});
      }).toList();
    } catch (e) {
      // Fallback para dados locais
      final localTasks = _localStorage.read('tasks_$userId') ?? [];
      return localTasks.map((task) => Task.fromMap(task)).toList();
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _firestore.collection('tasks').add(task.toMap());
    } catch (e) {
      // Salva localmente se offline
      final localTasks = _localStorage.read('tasks_${task.userId}') ?? [];
      localTasks.add(task.toMap());
      await _localStorage.save('tasks_${task.userId}', localTasks);
    }
  }

}