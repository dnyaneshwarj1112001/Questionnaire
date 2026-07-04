import 'package:flutterquationnaireapp/data/models/quation_model.dart';

import '../models/questionnaire_model.dart';

final List<QuestionnaireModel> questionnaires = [
  QuestionnaireModel(
    id: "1",
    title: "Employee Survey",
    description: "Share your workplace experience.",
  ),
  QuestionnaireModel(
    id: "2",
    title: "Customer Feedback",
    description: "Help us improve our services.",
  ),
  QuestionnaireModel(
    id: "3",
    title: "Flutter Assessment",
    description: "Test your Flutter knowledge.",
  ),
];

final Map<String, List<QuestionModel>> questionnaireQuestions = {
  "1": [
    QuestionModel(
      id: "1",
      question: "How satisfied are you with your workplace?",
      options: ["Excellent", "Good", "Average", "Poor"],
    ),
    QuestionModel(
      id: "2",
      question: "How is your work-life balance?",
      options: ["Very Good", "Good", "Average", "Poor"],
    ),
    QuestionModel(
      id: "3",
      question: "Do you receive proper support from your manager?",
      options: ["Always", "Sometimes", "Rarely", "Never"],
    ),
    QuestionModel(
      id: "4",
      question: "Are you satisfied with company policies?",
      options: ["Yes", "Mostly", "No", "Not Sure"],
    ),
    QuestionModel(
      id: "5",
      question: "Would you recommend this company to others?",
      options: ["Definitely", "Maybe", "Not Sure", "No"],
    ),
  ],

  "2": [
    QuestionModel(
      id: "1",
      question: "How satisfied are you with our service?",
      options: ["Excellent", "Good", "Average", "Poor"],
    ),
    QuestionModel(
      id: "2",
      question: "Was our staff helpful?",
      options: ["Yes", "Somewhat", "No", "Not Applicable"],
    ),
    QuestionModel(
      id: "3",
      question: "Was the product quality satisfactory?",
      options: ["Excellent", "Good", "Average", "Poor"],
    ),
    QuestionModel(
      id: "4",
      question: "Would you recommend us to others?",
      options: ["Definitely", "Maybe", "No", "Not Sure"],
    ),
    QuestionModel(
      id: "5",
      question: "Overall experience with our service?",
      options: ["Excellent", "Good", "Average", "Poor"],
    ),
  ],

  "3": [
    QuestionModel(
      id: "1",
      question: "Flutter is developed by?",
      options: ["Google", "Microsoft", "Meta", "Apple"],
    ),
    QuestionModel(
      id: "2",
      question: "Which language is used in Flutter?",
      options: ["Java", "Kotlin", "Dart", "Swift"],
    ),
    QuestionModel(
      id: "3",
      question: "Which widget is immutable?",
      options: [
        "StatefulWidget",
        "StatelessWidget",
        "InheritedWidget",
        "Container",
      ],
    ),
    QuestionModel(
      id: "4",
      question: "Which command runs a Flutter app?",
      options: [
        "flutter run",
        "flutter build",
        "flutter create",
        "flutter doctor",
      ],
    ),
    QuestionModel(
      id: "5",
      question: "Which package is commonly used for state management?",
      options: ["GetX", "Dio", "Hive", "Retrofit"],
    ),
  ],
};
