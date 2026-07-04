class SubmissionModel {
  final String questionnaireId;
  final String questionnaireTitle;
  final Map<String, String> answers;
  final String submittedAt;
  final double latitude;
  final double longitude;
  final String userPhone;

  SubmissionModel({
    required this.userPhone,
    required this.questionnaireId,
    required this.questionnaireTitle,
    required this.answers,
    required this.submittedAt,
    required this.latitude,
    required this.longitude,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      userPhone: json["userPhone"].toString(),
      questionnaireId: json['questionnaireId'],
      questionnaireTitle: json['questionnaireTitle'],
      answers: Map<String, String>.from(json['answers']),
      submittedAt: json['submittedAt'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userPhone": userPhone,
      "questionnaireId": questionnaireId,
      "questionnaireTitle": questionnaireTitle,
      "answers": answers,
      "submittedAt": submittedAt,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
