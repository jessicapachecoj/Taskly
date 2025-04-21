import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class TaskService {
  final LocalStorageService _localStorage = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();

  TaskService() {
    _setupConnectivityListener();
  }

  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncLocalTasks();
      }
    });
  }

  Future<void> _syncLocalTasks() async {
    final user = Get.find<AuthService>().user;
    if (user != null) {
      final localTasks = _localStorage.read('tasks_${user.uid}') ?? [];
      if (localTasks.isNotEmpty) {
        for (final task in localTasks) {
          await _firestore.collection('tasks').add(task);
        }
        await _localStorage.remove('tasks_${user.uid}');
      }
    }
  }
}