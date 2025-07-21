import 'dart:convert';
import 'package:helpdesk/client/api_client.dart';
import 'package:http/http.dart' as http;
import '../models/engineer.dart';
import '../models/user_model.dart';

class ApiService {


  Future<Engineer?> login(String email, String password) async {
    final url = Uri.parse('${ApiClient.baseUrl}am_login.php');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      ) ;//.timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          return Engineer.fromJson(data['user']);
        } else {
          print("Login failed: ${data['message']}");
        }
      } else {
        print("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception during login: $e");
    }

    return null;
  }

  Future<List<Engineer>> getEngineersByManager(int managerId) async {
    final url = Uri.parse('${ApiClient.baseUrl}my_team.php');

    try {
      final response = await http.post(
        url,
        body: {'manager_id': managerId.toString()},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'success') {
          final List<dynamic> engineerList = jsonData['engineers'];
          return engineerList.map((e) => Engineer.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print("API error: $e");
    }

    return []; // return empty list on error
  }



}
