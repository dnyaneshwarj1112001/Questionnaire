import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/core/constants/Appcolors.dart';
import 'package:flutterquationnaireapp/core/custome_Widgets/custome_TextField.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),

          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.app_registration,
                  size: 80,
                  color: Appcolors.logoiconcolor,
                ),
                const SizedBox(height: 20),
                const Text(
                  AppStrigs.joinUs,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  AppStrigs.fillinthedetailsbelowtoregister,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),

                CustomeTextfield(
                  onChanged: (_) {
                    authController.validateForm(
                      phoneController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  inputformaters: [LengthLimitingTextInputFormatter(10)],
                  obscureText: false,
                  keybordtype: TextInputType.number,
                  iconData: Icons.phone,
                  controller: phoneController,
                  labletext: AppStrigs.phoneNumber,
                  validator: (phoneController) {
                    if (phoneController == null || phoneController.isEmpty) {
                      return AppStrigs.pleaseEnterPhoneNumber;
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneController)) {
                      return AppStrigs.entervalidphoneNumber;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomeTextfield(
                  onChanged: (_) {
                    authController.validateForm(
                      phoneController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  obscureText: true,
                  iconData: Icons.lock,
                  controller: passwordController,
                  labletext: AppStrigs.password,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomeTextfield(
                  onChanged: (_) {
                    authController.validateForm(
                      phoneController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  iconData: Icons.lock_clock_outlined,
                  controller: confirmPasswordController,
                  labletext: AppStrigs.confirmPassword,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrigs.pleaseconfirmyourpassword;
                    }
                    if (value != passwordController.text) {
                      return AppStrigs.passwordnotmatch;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                Obx(
                  () => ElevatedButton(
                    onPressed: authController.isFormValid.value
                        ? () {
                            if (formKey.currentState!.validate()) {
                              authController.registerUser(
                                phoneController.text.trim(),
                                passwordController.text.trim(),
                                confirmPasswordController.text.trim(),
                              );
                            }
                          }
                        : null,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      AppStrigs.register,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                  child: const Text(AppStrigs.alreadyhaveaccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
