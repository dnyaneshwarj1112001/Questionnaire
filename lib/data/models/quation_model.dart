class QuestionModel {
  final String id;
  final String question;
  final List<String> options;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "question": question, "options": options};
  }
}
