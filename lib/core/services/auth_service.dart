import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskly/core/constants/app_constants.dart';
import 'package:taskly/core/constants/firebase_constants.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case FirebaseConstants.weakPassword:
        message = 'Password is too weak';
        break;
      case FirebaseConstants.emailInUse:
        message = 'Email is already in use';
        break;
      case FirebaseConstants.userNotFound:
        message = 'User not found';
        break;
      case FirebaseConstants.wrongPassword:
        message = 'Wrong password';
        break;
      default:
        message = AppConstants.genericError;
    }
    Get.snackbar('Error', message);
  }
}