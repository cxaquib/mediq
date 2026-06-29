import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _storage;
  
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _roleKey = 'user_role';
  static const String _refreshTokenKey = 'refresh_token';

  StorageService(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _storage.getString(_tokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.setString(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.getString(_refreshTokenKey);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _storage.setString(_userKey, jsonEncode(userData));
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final data = _storage.getString(_userKey);
    if (data != null && data.isNotEmpty) {
      return Map<String, dynamic>.from(jsonDecode(data));
    }
    return null;
  }

  Future<void> saveRole(String role) async {
    await _storage.setString(_roleKey, role);
  }

  Future<String?> getRole() async {
    return _storage.getString(_roleKey);
  }

  Future<void> clearAll() async {
    await _storage.clear();
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}