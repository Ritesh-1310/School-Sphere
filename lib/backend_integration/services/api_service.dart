// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/admin_announcement.dart';
import '../models/teacher_announcement.dart';

class APIService {
  final String baseUrl = "https://sms-backend-sandy.vercel.app/api";

  // login
  Future<String> login(String userType, String email, String password) async {
    Uri url = Uri.parse('$baseUrl/$userType/login');
    print(url);
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    return response.body;
  }

  // register
  Future<String> register(
      String userType, Map<String, dynamic> userData) async {
    Uri url;
    if (userType == 'admin') {
      url = Uri.parse('$baseUrl/$userType/register');
    } else {
      url = Uri.parse('$baseUrl/admin/$userType/register');
    }
    final response = await http.post(
      url,
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }

  // delete user
  Future<String> deleteUser(String userType, String userID) async {
    final url = Uri.parse('$baseUrl/$userType/delete');
    final response = await http.delete(
      url,
      body: jsonEncode({'userID': userID}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }

  // fetch admin announcement
  Future<List<AdminAnnouncement>> fetchAllAnnouncements() async {
    final url = Uri.parse('$baseUrl/admin/announcement/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => AdminAnnouncement.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  // post admin announcement 
  Future<String> postAnnouncement(
      String title, String content, String author) async {
    final url = Uri.parse('$baseUrl/admin/announcement/create');
    final response = await http.post(
      url,
      body: jsonEncode({'title': title, 'content': content, 'by': author}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }

  // update admin announcement
  Future<String> updateAnnouncement(String id, String title, String content, String author) async {
    final url = Uri.parse('$baseUrl/admin/announcement/update');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        '_id': id,
        'title': title,
        'content': content,
        'by': author,
      }),
    );
    return response.body;
  }

  // delete admin announcement
  Future<String> deleteAnnouncement(String id) async {
    final url = Uri.parse('$baseUrl/admin/announcement/delete');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'announcementID': id}),
    );
    return response.body;
  }


  // fetch teacher announcement
  Future<List<TeacherAnnouncement>> fetchAllTeacherAnnouncements() async {
    final url = Uri.parse('$baseUrl/teacher/announcement/all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => TeacherAnnouncement.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  // post admin announcement 
  Future<String> postTeacherAnnouncement(
      String title, String content, String author) async {
    final url = Uri.parse('$baseUrl/teacher/announcement/create');
    final response = await http.post(
      url,
      body: jsonEncode({'title': title, 'content': content, 'by': author}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }

  // update admin announcement
  Future<String> updateTeacherAnnouncement(String id, String title, String content, String author) async {
    final url = Uri.parse('$baseUrl/teacher/announcement/update');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        '_id': id,
        'title': title,
        'content': content,
        'by': author,
      }),
    );
    return response.body;
  }

  // delete admin announcement
  Future<String> deleteTeacherAnnouncement(String id) async {
    final url = Uri.parse('$baseUrl/teacher/announcement/delete');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'announcementID': id}),
    );
    return response.body;
  }
}



