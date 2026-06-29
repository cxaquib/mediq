import 'package:flutter/foundation.dart';
import 'auth_provider.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _name;
  String? _email;
  String? _phone;
  String? _avatarUrl;
  Map<String, dynamic>? _profileData;
  AuthProvider? _authProvider;

  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get avatarUrl => _avatarUrl;
  Map<String, dynamic>? get profileData => _profileData;
  bool get isLoggedIn => _userId != null;

  void updateAuth(AuthProvider auth) {
    _authProvider = auth;
    notifyListeners();
  }

  void setProfile({
    required String userId,
    required String name,
    required String email,
    String? phone,
    String? avatarUrl,
    Map<String, dynamic>? additionalData,
  }) {
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
    _avatarUrl = avatarUrl;
    if (additionalData != null) {
      _profileData = additionalData;
    }
    notifyListeners();
  }

  void updateProfile(Map<String, dynamic> data) {
    _profileData = {...?_profileData, ...data};
    if (data.containsKey('name')) _name = data['name'];
    if (data.containsKey('email')) _email = data['email'];
    if (data.containsKey('phone')) _phone = data['phone'];
    if (data.containsKey('avatarUrl')) _avatarUrl = data['avatarUrl'];
    notifyListeners();
  }

  void clearProfile() {
    _userId = null;
    _name = null;
    _email = null;
    _phone = null;
    _avatarUrl = null;
    _profileData = null;
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    // TODO: Fetch profile from API
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock profile data
    setProfile(
      userId: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+1234567890',
      additionalData: {
        'dateOfBirth': '1990-01-01',
        'address': '123 Main St',
        'emergencyContact': '+0987654321',
      },
    );
  }
}