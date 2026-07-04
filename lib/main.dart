import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/controllers/auth_controller.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/login_screen.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/register_screen.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/splash_screen.dart';
import 'package:flutterquationnaireapp/views/home/home_screen.dart';
import 'package:flutterquationnaireapp/views/questionnaire/questionnaire_screen.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("authBox");
  await Hive.openBox('submissionBox');
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
        GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.home, page: () => HomeScreen()),
        GetPage(
          name: AppRoutes.questionnaire,
          page: () => QuestionnaireScreen(),
        ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
