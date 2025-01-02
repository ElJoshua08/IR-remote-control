import 'objectbox.g.dart'; // Generated code

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static ObjectBox create() {
    final store = openStore(); // Initializes the database
    return ObjectBox._create(store);
  }
}
