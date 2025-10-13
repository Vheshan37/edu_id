import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._privateConstructor();

  static final SecureStorage _instance = SecureStorage._privateConstructor();

  static SecureStorage get instance => _instance;

  FlutterSecureStorage? _storage;

  FlutterSecureStorage get storage {
    _storage ??= const FlutterSecureStorage();
    return _storage!;
  }
}