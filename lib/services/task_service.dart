import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskly/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Criar tarefa
  Future<void> createTask(TaskModel task) async {
    try {
      await _db.collection('tasks').add(task.toMap());
    } catch (e) {
      print("Erro ao criar tarefa: $e");
    }
  }

  // Recuperar todas as tarefas
  Stream<List<TaskModel>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var task = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
        task.id = doc.id;  
        return task;
      }).toList();
    });
  }

  // Deletar tarefa
  Future<void> deleteTask(String id) async {
    try {
      await _db.collection('tasks').doc(id).delete();
    } catch (e) {
      print("Erro ao deletar tarefa: $e");
    }
  }

  // Atualizar tarefa (marcar como concluída ou atualizar os dados)
  Future<void> updateTask(TaskModel task) async {
    try {
      await _db.collection('tasks').doc(task.id).update(task.toMap());
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }
}
