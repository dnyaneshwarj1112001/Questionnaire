import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

import '../../../core/constants/Appcolors.dart';

import '../../../core/custome_Widgets/custome_TextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateForm() {
    authController.validateLoginForm(
      phoneController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrigs.login), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                const Icon(
                  Icons.lock_open_rounded,
                  size: 90,
                  color: Appcolors.logoiconcolor,
                ),

                const SizedBox(height: 20),

                const Text(
                  AppStrigs.welcomeback,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  AppStrigs.logintocontinue,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                CustomeTextfield(
                  controller: phoneController,
                  obscureText: false,
                  labletext: AppStrigs.phoneNumber,
                  iconData: Icons.phone,
                  keybordtype: TextInputType.phone,
                  inputformaters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (_) => validateForm(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrigs.pleaseEnterPhoneNumber;
                    }

                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return AppStrigs.entervalidphoneNumber;
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: (_) => validateForm(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrigs.pleaseEnterPassWord;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppStrigs.password,
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoginValid.value
                        ? () {
                            if (formKey.currentState!.validate()) {
                              authController.loginUser(
                                phoneController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.logoiconcolor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      AppStrigs.loginButton,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrigs.dontHaveAccount),

                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.register);
                      },
                      child: const Text(AppStrigs.register),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
