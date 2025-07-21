
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/engineer.dart';
import '../models/user_model.dart';
import '../services/help_services.dart';

class AuthController with ChangeNotifier {
  Engineer? _user;
  bool _isLoading = false;
  String? _errorMessage;

  Engineer? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Engineer? loginResponse = await _apiService.login(email, password);

      if (loginResponse != null) {
        _user = loginResponse;
        // Save username (or email or name)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', _user!.engineerName); // or _user!.mail
        await prefs.setInt('userid', _user!.id); // or _user!.mail

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Invalid email or password";
      }
    } catch (e) {
      _errorMessage = "Login failed: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}