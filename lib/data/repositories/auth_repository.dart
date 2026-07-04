import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/user_model.dart';

class AuthRepository {
  final Box _authBox = Hive.box('authBox');

  Future<bool> registerUser(String phone, String password) async {
    if (_authBox.containsKey(phone)) {
      return false;
    }

    UserModel user = UserModel(phone: phone, password: password);

    await _authBox.put(phone, jsonEncode(user.toJson()));

    return true;
  }

  UserModel? getUser(String phone) {
    final String? userString = _authBox.get(phone);

    if (userString == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(userString));
  }

  Future<void> saveLoginSession(String phone) async {
    await _authBox.put('isLoggedIn', true);
    await _authBox.put('currentUserPhone', phone);
  }

  bool isLoggedIn() {
    return _authBox.get('isLoggedIn', defaultValue: false);
  }

  String getCurrentUserPhone() {
    return _authBox.get('currentUserPhone', defaultValue: '');
  }

  Future<void> logout() async {
    await _authBox.put('isLoggedIn', false);
    await _authBox.delete('currentUserPhone');
  }
}
