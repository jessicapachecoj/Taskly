import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Registrar novo usuário
  Future<UserCredential?> register(String name, String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user?.updateDisplayName(name);  
      return cred;
    } catch (e) {
      Get.snackbar("Erro", e.toString());
      return null;
    }
  }

  // Login
  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Erro", e.toString());
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Usuário atual
  User? get currentUser => _auth.currentUser;

  static AuthService get to => Get.find<AuthService>();
}
