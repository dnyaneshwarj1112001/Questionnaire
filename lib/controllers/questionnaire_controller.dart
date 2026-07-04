import 'package:flutterquationnaireapp/data/models/quation_model.dart';
import 'package:flutterquationnaireapp/data/repositories/app_repository.dart';
import 'package:get/get.dart';

import '../data/models/questionnaire_model.dart';

class QuestionnaireController extends GetxController {
  final QuestionnaireRepository _repository = QuestionnaireRepository();

  RxList<QuestionnaireModel> questionnaires = <QuestionnaireModel>[].obs;

  RxList<QuestionModel> questions = <QuestionModel>[].obs;

  RxBool isLoading = false.obs;

  RxMap<String, String> selectedAnswers = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestionnaires();
  }

  void loadQuestionnaires() {
    isLoading.value = true;

    questionnaires.assignAll(_repository.getQuestionnaires());

    isLoading.value = false;
  }

  void loadQuestions(String questionnaireId) {
    isLoading.value = true;

    questions.assignAll(_repository.getQuestions(questionnaireId));

    selectedAnswers.clear();

    isLoading.value = false;
  }

  void selectAnswer(String questionId, String selectedOption) {
    selectedAnswers[questionId] = selectedOption;
  }

  bool isAllQuestionsAnswered() {
    return selectedAnswers.length == questions.length;
  }
}
