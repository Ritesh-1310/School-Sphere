import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management_app/backend_integration/models/class_model.dart';

class ClassService {
  final String baseUrl = "https://sms-backend-sandy.vercel.app/api";

  Future<String> addClass(Map<String, dynamic> classJson) async {
    final url = Uri.parse('$baseUrl/admin/class/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(classJson),
    );
    return response.body;
  }

  Future<String> updateClass(String id, String className, String teacherID,
      List<String> studentIDs) async {
    final url = Uri.parse('$baseUrl/admin/class/update');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        '_id': id,
        'className': className,
        'teacherID': teacherID,
        'studentIDs': studentIDs,
      }),
    );
    return response.body;
  }

  Future<String> deleteClass(String id) async {
    final url = Uri.parse('$baseUrl/admin/class/delete');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'classID': id}),
    );
    return response.body;
  }

  Future<List<Class>> fetchAllClasses() async {
    final url = Uri.parse('$baseUrl/admin/class/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => Class.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<String> fetchTeacherName(String teacherID) async {
    final url = Uri.parse('$baseUrl/admin/teacher/get');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'teacherID': teacherID}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Map<String, dynamic> data = responseData['data'];
      return "${data['fname']} ${data['lname']}"; // Assuming the teacher's first name is provided
    } else {
      throw Exception('Failed to fetch teacher name');
    }
  }

  Future<String> fetchStudentName(String studentID) async {
    final url = Uri.parse('$baseUrl/admin/student/get');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'studentID': studentID}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Map<String, dynamic> data = responseData['data'];
      return "${data['fname']} ${data['lname']}"; // Assuming the student's first name is provided
    } else {
      throw Exception('Failed to fetch student name');
    }
  }
}
