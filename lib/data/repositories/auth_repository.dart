import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskly/core/constants/app_constants.dart';
import 'package:taskly/core/constants/firebase_constants.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUpWithEmailAndPassword(
    String email, 
    String password, 
    String name
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email, 
    String password
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case FirebaseConstants.weakPassword:
        message = 'Senha muito fraca (mínimo 6 caracteres)';
        break;
      case FirebaseConstants.emailInUse:
        message = 'Este email já está cadastrado';
        break;
      case FirebaseConstants.userNotFound:
        message = 'Usuário não encontrado';
        break;
      case FirebaseConstants.wrongPassword:
        message = 'Senha incorreta';
        break;
      case FirebaseConstants.tooManyRequests:
        message = 'Muitas tentativas. Tente novamente mais tarde';
        break;
      case FirebaseConstants.userDisabled:
        message = 'Esta conta foi desativada';
        break;
      case FirebaseConstants.operationNotAllowed:
        message = 'Operação não permitida';
        break;
      case FirebaseConstants.invalidEmail:
        message = 'Email inválido';
        break;
      default:
        message = AppConstants.genericError;
    }
    Get.snackbar('Erro', message);
  }
}