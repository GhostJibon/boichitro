import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage
  var _storage;

  // initilize secure storage
  SecureStorageService() {
    _storage = FlutterSecureStorage();
  }

  Future readValue({required String key}) async {
    // Read value
    return await _storage.read(key: key);
  }

  Future<Map<String, String>> readAllValues() async {
    // Read all values
    Map<String, String> allValues = await _storage.readAll();
    return allValues;
  }

  Future<void> writeValue({required String key, required String value}) async {
    // Write value
    await _storage.write(key: key, value: value);
  }

  Future<void> deleteValue({required String key}) async {
    //Delete value
    await _storage.delete(key: key);
  }
}
