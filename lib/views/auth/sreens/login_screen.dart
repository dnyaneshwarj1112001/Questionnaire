import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
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
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                /// Phone
                CustomeTextfield(
                  controller: phoneController,
                  obscureText: false,
                  labletext: "Phone Number",
                  iconData: Icons.phone,
                  keybordtype: TextInputType.phone,
                  inputformaters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (_) => validateForm(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter phone number";
                    }

                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter valid phone number";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                /// Password
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: (_) => validateForm(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
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

                /// Login Button
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
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),

                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.register);
                      },
                      child: const Text("Register"),
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
