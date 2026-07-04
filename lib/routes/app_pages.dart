import 'package:get/get.dart';

import 'app_routes.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/splash_screen.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/register_screen.dart';
import 'package:flutterquationnaireapp/views/auth/sreens/login_screen.dart';
import 'package:flutterquationnaireapp/views/home/home_screen.dart';
import 'package:flutterquationnaireapp/views/questionnaire/questionnaire_screen.dart';
import 'package:flutterquationnaireapp/views/profile/profile_screen.dart';

final List<GetPage<dynamic>> appPages = [
  GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
  GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
  GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  GetPage(name: AppRoutes.home, page: () => HomeScreen()),
  GetPage(name: AppRoutes.questionnaire, page: () => QuestionnaireScreen()),
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
];
