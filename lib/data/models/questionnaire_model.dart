class QuestionnaireModel {
  final String id;
  final String title;
  final String description;

  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "description": description};
  }
}
