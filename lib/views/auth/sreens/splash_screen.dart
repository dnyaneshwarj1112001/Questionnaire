import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/controllers/auth_controller.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (authController.isLoggedIn.value) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0xffF3F0FF),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.assignment_turned_in_rounded,
                      size: 80,
                      color: Color(0xff6A4CF4),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              AppStrigs.appname,

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff222244),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              AppStrigs.splashtext,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            const SizedBox(height: 50),

            const CircularProgressIndicator(color: Color(0xff6A4CF4)),
          ],
        ),
      ),
    );
  }
}
