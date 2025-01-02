import "package:ir_remote_control/models/user_preferences.dart";
import "package:ir_remote_control/store.dart";

class UserPreferencesService {
  final ObjectBox objectBox;

  UserPreferencesService(this.objectBox);

  List<UserPreferences> getPreferences() {
    final box = objectBox.store.box<UserPreferences>();
    return box.getAll();
  }

  void setPreference(String key, dynamic value) {
    final box = objectBox.store.box<UserPreferences>();
    
    box.put(UserPreferences(key: key, value: value));
  }
}
