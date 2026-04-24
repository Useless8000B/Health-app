import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exam_model.dart';

class ApiService {
  static const String baseUrl = String.fromEnvironment('API_URL');

  Future<List<ExamRecord>> getExams() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ExamRecord.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load exams: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> addExam(ExamRecord exam) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(exam.toJson()),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
