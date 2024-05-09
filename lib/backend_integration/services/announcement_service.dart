// announcement_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin_announcement.dart';
import '../models/teacher_announcement.dart';

class AnnouncementService {
  final String baseUrl = "https://sms-backend-sandy.vercel.app/api";

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

  Future<String> updateAnnouncement(
      String id, String title, String content, String author) async {
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

  Future<String> deleteAnnouncement(String id) async {
    final url = Uri.parse('$baseUrl/admin/announcement/delete');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'announcementID': id}),
    );
    return response.body;
  }

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

  Future<String> updateTeacherAnnouncement(
      String id, String title, String content, String author) async {
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
