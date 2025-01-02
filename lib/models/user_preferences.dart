import 'package:objectbox/objectbox.dart';

@Entity()
class UserPreferences {
  int id = 0;

  String key;
  String value;

  UserPreferences({
    required this.key,
    required this.value,
  });
}
