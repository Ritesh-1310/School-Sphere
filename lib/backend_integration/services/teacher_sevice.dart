// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class APIService {
  static const String baseUrl = "https://sms-backend-sandy.vercel.app/api";

  static Future<List<TeacherRegister>> fetchTeachers() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/teacher/all/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<TeacherRegister> teachers = [];
      for (var teacherData in data) {
        teachers.add(TeacherRegister.fromJson(teacherData));
      }
      return teachers;
    } else {
      throw Exception('Failed to fetch teachers');
    }
  }
}
