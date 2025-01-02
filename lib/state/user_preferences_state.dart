import 'package:flutter/material.dart';
import 'package:ir_remote_control/objectbox.g.dart'; // Ensure this import is correct
import 'package:ir_remote_control/services/user_preferences_service.dart';

class UserPreferencesStateManager extends ChangeNotifier {
  Map<String, dynamic> _preferences = {};
  final UserPreferencesService _userPreferencesService;

  UserPreferencesStateManager(ObjectBox objectBox)
      : _userPreferencesService = UserPreferencesService(objectBox) {
    _loadUserPreferences();
  }

  // Get all preferences
  Map<String, dynamic> get preferences => _preferences;

  // Get a specific preference, returns null if not found
  dynamic getPreference(String key) {
    return _preferences.containsKey(key) ? _preferences[key] : null;
  }

  // Set a specific preference
  Future<void> setPreference(String key, dynamic value) async {
    _preferences[key] = value;
    await _userPreferencesService.setPreference(key, value);
    notifyListeners();
  }

  // Load preferences from ObjectBox
  void _loadUserPreferences() async {
    final userPreferences = _userPreferencesService.getPreferences();
    _preferences = {for (var pref in userPreferences) pref.key: pref.value};
    notifyListeners();
  }
}
