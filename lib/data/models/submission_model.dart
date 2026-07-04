class SubmissionModel {
  final String quationnaireTitle;
  final Map<String, String> answers;
  final double latitude;
  final double longitude;
  final DateTime submittedAt;

  SubmissionModel({
    required this.quationnaireTitle,
    required this.answers,
    required this.latitude,
    required this.longitude,
    required this.submittedAt,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      quationnaireTitle: json["quationnaireTitle"],
      answers: Map<String, String>.from(json["answers"]),
      latitude: json["latitude"],
      longitude: json["longitude"],
      submittedAt: DateTime.parse(json["submittedAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quationnaireTitle": quationnaireTitle,
      "answers": answers,
      "latitude": latitude,
      "longitude": longitude,
      "submittedAt": submittedAt.toIso8601String(),
    };
  }
}
