import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/core/constants/Appcolors.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/questionnaire_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/quationcard.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController authController = Get.find();
  final QuestionnaireController questionnaireController = Get.put(
    QuestionnaireController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrigs.home),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Appcolors.cwhite,
              child: IconButton(
                icon: const Icon(Icons.person, color: Appcolors.logoiconcolor),
                onPressed: () {
                  Get.toNamed(AppRoutes.profile);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (questionnaireController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: questionnaireController.questionnaires.length,
            itemBuilder: (context, index) {
              final questionnaire =
                  questionnaireController.questionnaires[index];

              return QuestionnaireCard(
                title: questionnaire.title,
                description: questionnaire.description,
                onTap: () async {
                  questionnaireController.loadQuestions(
                    questionnaire.id,
                    questionnaire.title,
                  );

                  final result = await Get.toNamed(
                    AppRoutes.questionnaire,
                    arguments: questionnaire.title,
                  );

                  if (result == true) {
                    Get.snackbar(
                      AppStrigs.successful,
                      AppStrigs.questionnairesubmittedsuccessfully,
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}
