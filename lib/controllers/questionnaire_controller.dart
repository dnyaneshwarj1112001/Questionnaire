import 'package:flutterquationnaireapp/controllers/auth_controller.dart';
import 'package:flutterquationnaireapp/core/constants/AppStrgs.dart';
import 'package:flutterquationnaireapp/data/models/quation_model.dart';
import 'package:flutterquationnaireapp/data/models/submission_model.dart';
import 'package:flutterquationnaireapp/data/repositories/questionaryrepository.dart';
import 'package:flutterquationnaireapp/data/repositories/submission_repositories.dart';
import 'package:flutterquationnaireapp/utilities/appsnackbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/models/questionnaire_model.dart';

class QuestionnaireController extends GetxController {
  final QuestionnaireRepository _repository = QuestionnaireRepository();
  final SubmissionRepository _submissionRepository = SubmissionRepository();
  RxBool isSubmitting = false.obs;

  RxList<QuestionnaireModel> questionnaires = <QuestionnaireModel>[].obs;

  RxList<QuestionModel> questions = <QuestionModel>[].obs;
  final authController = Get.find<AuthController>();
  RxBool isLoading = false.obs;

  RxMap<String, String> selectedAnswers = <String, String>{}.obs;
  String currentQuestionnaireId = "";
  String currentQuestionnaireTitle = "";

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

  void loadQuestions(String questionnaireId, String questionnaireTitle) {
    isLoading.value = true;

    currentQuestionnaireId = questionnaireId;
    currentQuestionnaireTitle = questionnaireTitle;

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

  Future<void> submitQuestionnaire() async {
    if (isSubmitting.value) return;

    isSubmitting.value = true;

    try {
      if (!isAllQuestionsAnswered()) {
        AppSnackbar.error(AppStrigs.incomplete, AppStrigs.pleaseansallquations);
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        AppSnackbar.error(AppStrigs.error, "Please enable location services.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        AppSnackbar.error(AppStrigs.error, "Location permission denied.");
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        AppSnackbar.error(
          AppStrigs.error,
          "Location permission permanently denied.",
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final submission = SubmissionModel(
        userPhone: authController.currentPositionUser.value,
        questionnaireId: currentQuestionnaireId,
        questionnaireTitle: currentQuestionnaireTitle,
        answers: Map<String, String>.from(selectedAnswers),
        submittedAt: DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()),
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _submissionRepository.saveSubmission(submission);

      authController.loadProfile();

      selectedAnswers.clear();

      Get.back(result: true);
    } catch (e) {
      AppSnackbar.error(AppStrigs.error, e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
