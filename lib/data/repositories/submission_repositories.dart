import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/submission_model.dart';

class SubmissionRepository {
  final Box submissionBox = Hive.box('submissionBox');

  Future<void> saveSubmission(SubmissionModel submission) async {
    await submissionBox.add(jsonEncode(submission.toJson()));
  }

  List<SubmissionModel> getAllSubmissions() {
    return submissionBox.values.map((item) {
      return SubmissionModel.fromJson(jsonDecode(item as String));
    }).toList();
  }

  List<SubmissionModel> getSubmissionsByPhone(String phone) {
    return submissionBox.values
        .map((item) => SubmissionModel.fromJson(jsonDecode(item as String)))
        .where((submission) => submission.userPhone == phone)
        .toList()
        .reversed
        .toList();
  }

  int getSubmissionCount(String phone) {
    return submissionBox.values.where((item) {
      final submission = SubmissionModel.fromJson(jsonDecode(item as String));
      return submission.userPhone == phone;
    }).length;
  }

  Future<void> clearAll() async {
    await submissionBox.clear();
  }
}
