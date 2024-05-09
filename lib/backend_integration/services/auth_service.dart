// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://sms-backend-sandy.vercel.app/api";

  Future<String> login(String userType, String email, String password) async {
    Uri url = Uri.parse('$baseUrl/$userType/login');
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }

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

  Future<String> deleteUser(String userType, String userID) async {
    final url = Uri.parse('$baseUrl/$userType/delete');
    final response = await http.delete(
      url,
      body: jsonEncode({'userID': userID}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.body;
  }
}
