import 'package:flutter/material.dart';
import 'package:ir_remote_control/database/database_helper.dart';

class UserPreferencesStateManager extends ChangeNotifier {
  Map<String, dynamic> _preferences = {};

  UserPreferencesStateManager() {
    _loadPreferences();
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

    // Save updated preference to SQLite
    await DatabaseHelper.instance.setPreference(key, value);

    notifyListeners();
  }

  // Load preferences from SQLite
  void _loadPreferences() async {
    final prefs = await DatabaseHelper.instance.getAllPreferences();
    _preferences = prefs;
    notifyListeners();
  }
}
