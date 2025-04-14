import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions(String category, String difficulty) async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=5&category=$category&difficulty=$difficulty&type=multiple',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((q) => Question.fromJson(q))
          .toList();
    } else {
      throw Exception("Failed to fetch questions.");
    }
  }
}
