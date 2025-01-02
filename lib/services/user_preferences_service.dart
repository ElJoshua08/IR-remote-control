import "package:ir_remote_control/models/user_preferences.dart";
import "package:ir_remote_control/objectbox.g.dart";
import "package:ir_remote_control/store.dart";

class UserPreferencesService {
  final ObjectBox objectBox;

  UserPreferencesService(this.objectBox);

  List<UserPreferences> getPreferences() {
    final box = objectBox.store.box<UserPreferences>();
    return box.getAll();
  }

  void setPreference(String key, String value) {
    final box = objectBox.store.box<UserPreferences>();

    final preference =
        box.query(UserPreferences_.key.equals(key)).build().findFirst();

    if (preference != null) {
      preference.value = value;
      box.put(preference);
    } else {
      box.put(UserPreferences(key: key, value: value));
    }
  }

  void removeAllPreferences() {
    final box = objectBox.store.box<UserPreferences>();
    box.removeAll();
  }
}
