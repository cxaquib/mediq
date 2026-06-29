import 'package:flutter/material.dart';
import '../services/storage_service.dart';

enum UserRole { patient, doctor, admin }

class AuthProvider extends ChangeNotifier {
  final StorageService _storage;
  
  String? _token;
  String? _refreshToken;
  UserRole? _role;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._storage) {
    _loadStoredAuth();
  }

  String? get token => _token;
  String? get refreshToken => _refreshToken;
  UserRole? get role => _role;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  bool get isPatient => _role == UserRole.patient;
  bool get isDoctor => _role == UserRole.doctor;
  bool get isAdmin => _role == UserRole.admin;

  Future<void> _loadStoredAuth() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _token = await _storage.getToken();
      _refreshToken = await _storage.getRefreshToken();
      final roleString = await _storage.getRole();
      _role = roleString != null ? UserRole.values.byName(roleString) : null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock login - replace with actual API call
      _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      _refreshToken = 'refresh_token_${DateTime.now().millisecondsSinceEpoch}';
      _role = UserRole.patient; // Determine from API response
      
      await _storage.saveToken(_token!);
      await _storage.saveRefreshToken(_refreshToken!);
      await _storage.saveRole(_role!.name);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, UserRole role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      _refreshToken = 'refresh_token_${DateTime.now().millisecondsSinceEpoch}';
      _role = role;
      
      await _storage.saveToken(_token!);
      await _storage.saveRefreshToken(_refreshToken!);
      await _storage.saveRole(_role!.name);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _refreshToken = null;
    _role = null;
    await _storage.clearAll();
    notifyListeners();
  }

  Future<bool> refreshAuthToken() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) return false;
      
      // TODO: Call refresh token API
      await Future.delayed(const Duration(milliseconds: 500));
      
      _token = 'new_token_${DateTime.now().millisecondsSinceEpoch}';
      await _storage.saveToken(_token!);
      notifyListeners();
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  void updateRole(UserRole role) {
    _role = role;
    _storage.saveRole(role.name);
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}