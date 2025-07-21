import 'package:flutter/material.dart';
import '../models/engineer.dart';
import '../services/help_services.dart';

class EngineerController with ChangeNotifier {
  List<Engineer> _engineers = [];
  bool _isLoading = false;

  List<Engineer> get engineers => _engineers;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchEngineers(int managerId) async {
    _isLoading = true;
    notifyListeners();

    _engineers = await _apiService.getEngineersByManager(managerId);
    //_engineers = await _apiService.getEngineersByManager(217);

    _isLoading = false;
    notifyListeners();
  }
}
