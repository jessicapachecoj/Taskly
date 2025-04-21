import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final _storage = GetStorage();

  Future<void> save(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  dynamic read(String key) {
    return _storage.read(key);
  }

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async {
    await _storage.erase();
  }
}