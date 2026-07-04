import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/questionnaire_controller.dart';

class QuestionnaireScreen extends StatefulWidget {
  QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final QuestionnaireController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments as String? ?? "Questionnaire";

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  final question = controller.questions[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q${index + 1}. ${question.question}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 15),

                          ...question.options.map(
                            (option) => Obx(
                              () => RadioListTile<String>(
                                value: option,
                                groupValue:
                                    controller.selectedAnswers[question.id],
                                title: Text(option),
                                onChanged: (value) {
                                  controller.selectAnswer(question.id, value!);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (!controller.isAllQuestionsAnswered()) {
                      Get.snackbar(
                        "Incomplete",
                        "Please answer all questions.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    /// Next Step
                    /// Save in Hive
                    /// Save DateTime
                    /// Save Lat Long

                    Get.snackbar(
                      "Success",
                      "Questionnaire Submitted",
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    Get.back();
                  },
                  child: const Text("Submit", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
