import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";

class UserPreferencesStateManager extends ChangeNotifier {
  Box<dynamic>?
      userPreferencesBox; 
  Map<String, dynamic> _preferences = {};

  UserPreferencesStateManager() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    // Open Hive box
    userPreferencesBox = await Hive.openBox('userPreferences');

    // Load preferences from the box or initialize an empty map
    _preferences = userPreferencesBox!.get('preferences', defaultValue: {})
        as Map<String, dynamic>;
    notifyListeners();
  }

  // Get all preferences
  Map<String, dynamic> get preferences => _preferences;

  // Get specific preference, returns null if not found
  dynamic getPreference(String key) {
    if (!_preferences.containsKey(key)) {
      return false;
    }

    return _preferences[key];
  }

  // Set specific preference
  Future<void> setPreference(String key, dynamic value) async {
    _preferences[key] = value;

    // Save updated preferences to Hive
    if (userPreferencesBox != null) {
      await userPreferencesBox!.put('preferences', _preferences);
    }

    notifyListeners();
  }
}
