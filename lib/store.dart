import 'objectbox.g.dart'; // Generated code

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final store = await openStore(); // Initializes the database
    return ObjectBox._create(store);
  }
}
