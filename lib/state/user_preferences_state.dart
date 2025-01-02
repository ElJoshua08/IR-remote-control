import 'package:flutter/material.dart';
import 'package:ir_remote_control/main.dart';
import 'package:ir_remote_control/services/user_preferences_service.dart';
import 'package:ir_remote_control/store.dart';

class UserPreferencesStateManager extends ChangeNotifier {
  Map<String, dynamic> _preferences = {};

  UserPreferencesStateManager(ObjectBox objectBox) {
    _loadUserPreferences();
  }

  void _loadUserPreferences() async {
    print("------ Loading user preferences ------");

    final userPreferences = UserPreferencesService(objectBox).getPreferences();

    print("Total user preferences loaded: ${userPreferences.length}");
    print("User preferences");
    for (var pref in userPreferences) {
      print("${pref.key} = ${pref.value}");
    }

    _preferences = {for (var pref in userPreferences) pref.key: pref.value};
    notifyListeners();
  }

  // Get all preferences
  Map<String, dynamic> get preferences => _preferences;

  // Get a specific preference, returns null if not found
  dynamic getPreference(String key) {
    return _preferences.containsKey(key) ? _preferences[key] : null;
  }

  // Set a specific preference
  Future<void> setPreference(String key, dynamic value) async {
    print("------ Setting user preference: $key = $value ------");

    UserPreferencesService(objectBox).setPreference(key, value);
    _preferences[key] = value;

    print("Total preferences: ${_preferences.length}");
    print("Current preferences: $_preferences");

    notifyListeners();
  }
}
