import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/core/routes/app_pages.dart';
import 'package:taskly/core/utils/app_snackbar.dart';
import 'package:taskly/data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final GetStorage storage;

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  AuthController({
    required this.authRepository,
    required this.storage,
  });

  @override
  void onInit() {
    user.bindStream(authRepository.authStateChanges);
    super.onInit();
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      print('Iniciando cadastro...');
      await authRepository.signUpWithEmailAndPassword(email, password, name);
      print('Cadastro concluído');
      storage.write('user_name', name);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      errorMessage.value = e.toString();
      AppSnackbar.showError('Erro no cadastro', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await authRepository.signInWithEmailAndPassword(email, password);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      errorMessage.value = e.toString();
      AppSnackbar.showError('Erro no login', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.signOut();
      storage.remove('user_name');
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      AppSnackbar.showError('Erro', 'Falha ao sair da aplicação');
    }
  }
}
