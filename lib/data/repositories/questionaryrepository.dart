import 'package:flutterquationnaireapp/data/models/quation_model.dart';

import '../providers/local_storage_service.dart';

import '../models/questionnaire_model.dart';

class QuestionnaireRepository {
  List<QuestionnaireModel> getQuestionnaires() {
    return questionnaires;
  }

  List<QuestionModel> getQuestions(String questionnaireId) {
    return questionnaireQuestions[questionnaireId] ?? [];
  }
}
