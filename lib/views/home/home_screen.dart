import 'package:flutter/material.dart';
import 'package:flutterquationnaireapp/routes/app_routes.dart';
import 'package:flutterquationnaireapp/widgets/quationcard.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/questionnaire_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthController authController = Get.find();
  final QuestionnaireController questionnaireController = Get.put(
    QuestionnaireController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Questionnairessss"), centerTitle: true),

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

                onTap: () {
                  questionnaireController.loadQuestions(questionnaire.id);

                  // Navigate later
                  Get.toNamed(AppRoutes.questionnaire);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
