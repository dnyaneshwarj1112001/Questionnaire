import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/core/constants/Appcolors.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:flutterquationnaireapp/utilities/appsnackbar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/user_model.dart';

class AuthController extends GetxController {
  final Box _authBox = Hive.box('authBox');
  var isLoggedIn = false.obs;

  var currentPositionUser =
      ''.obs; // To store logged-in phone/email for profile
  RxBool isFormValid = false.obs;
  RxBool isLoginValid = false.obs;
  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = _authBox.get('isLoggedIn', defaultValue: false);
    if (isLoggedIn.value) {
      currentPositionUser.value = _authBox.get(
        'currentUserPhone',
        defaultValue: '',
      );
    }
  }

  void registerUser(String phone, String password, String confirmPassword) {
    UserModel newUser = UserModel(phone: phone, password: password);
    String userJson = jsonEncode(newUser.toJson());

    _authBox.put(phone, userJson);
    AppSnackbar.success(
      AppStrigs.registrationSuccessful,
      AppStrigs.accountcreated,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  // login user logic
  void loginUser(String phone, String password) {
    if (phone.isEmpty || password.isEmpty) {
      AppSnackbar.error(AppStrigs.error, AppStrigs.pleasefillallthefields);
      return;
    }
    String? userString = _authBox.get(phone);

    if (userString == null) {
      AppSnackbar.error(AppStrigs.error, AppStrigs.userNotfound);
      return;
    }
    Map<String, dynamic> userMap = jsonDecode(userString);
    UserModel user = UserModel.fromJson(userMap);

    if (user.password == password) {
      _authBox.put('isLoggedIn', true);
      _authBox.put('currentUserPhone', phone);

      isLoggedIn.value = true;
      currentPositionUser.value = phone;
      AppSnackbar.success(AppStrigs.successful, AppStrigs.welcomeback);
      Get.offNamed(AppRoutes.home);
    } else {
      AppSnackbar.error(AppStrigs.error, AppStrigs.incorrectpassword);
    }
  }

  // --- LOGOUT LOGIC ---
  void logout() {
    _authBox.put('isLoggedIn', false);
    _authBox.delete('currentUserPhone'); // Clear active session user

    isLoggedIn.value = false;
    currentPositionUser.value = '';

    Get.snackbar(
      'Logged Out',
      'Session cleared successfully',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Navigate back to login and remove all previous screens from stack
    // Get.offAll(() => LoginScreen());
  }

  void validateForm(String phone, String password, String confirmPassword) {
    isFormValid.value =
        // RegExp(r'^[0-9]{10}$').hasMatch(phone) &&
        phone.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
  }

  void validateLoginForm(String phone, String password) {
    isLoginValid.value = phone.isNotEmpty && password.isNotEmpty;
  }
}
