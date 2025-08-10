import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Config {

  static var storage;

  static Future<void> init() async {
    storage = const FlutterSecureStorage();
  }

  static Future<void> saveAccessToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> getAccessToken() async {
    return await storage.read(key: 'auth_token');
  }

  static Future<void> deleteAccessToken() async {
    await storage.delete(key: 'auth_token');
  }

  static Future<bool> hasAccessToken() async {
    String? token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }


  static Future<void> saveUsername(String username) async {
    await storage.write(key: 'username', value: username);
  }

  static Future<String?> getUsername() async {
    return await storage.read(key: 'username');
  }

  static Future<void> deleteUsername() async {
    await storage.delete(key: 'username');
  }
  static Future<bool> hasUsername() async {
    String? username = await getUsername();
    return username != null && username.isNotEmpty;
  }

  static Future<void> clear() async {
    await storage.deleteAll();
  }
}
