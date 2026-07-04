import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/controllers/auth_controller.dart';
import 'package:flutterquationnaireapp/core/constants/Appcolors.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:flutterquationnaireapp/routes/app_pages.dart';
// Route pages are provided by `app_pages.dart`
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
      getPages: appPages,
      title: 'Flutter Demo',
      theme: Appcolors.theme,
    );
  }
}
