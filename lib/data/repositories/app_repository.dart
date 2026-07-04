import 'package:flutterquationnaireapp/data/models/quation_model.dart';

import '../dummy/questionnaire_data.dart';

import '../models/questionnaire_model.dart';

class QuestionnaireRepository {
  /// Get all questionnaires
  List<QuestionnaireModel> getQuestionnaires() {
    return questionnaires;
  }

  /// Get questions by questionnaire id
  List<QuestionModel> getQuestions(String questionnaireId) {
    return questionnaireQuestions[questionnaireId] ?? [];
  }
}
