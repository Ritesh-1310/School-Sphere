// student_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';

class StudentAPIService {
  final String baseUrl = "https://sms-backend-sandy.vercel.app/api";

  Future<List<StudentRegister>> fetchStudents() async {
    final url = Uri.parse('$baseUrl/admin/student/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => StudentRegister.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
