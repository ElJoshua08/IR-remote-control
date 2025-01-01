import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is null, initialize it
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> initializeDatabase() async {
     await database;
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    // Create `buttons` table
    await db.execute('''
      CREATE TABLE buttons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        address TEXT,
        command TEXT,
        type TEXT
      )
    ''');

    // Create `preferences` table
    await db.execute('''
      CREATE TABLE preferences (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  // Button operations
  // -----------------

  // Insert data into the buttons table
  Future<int> insertButton(Map<String, dynamic> button) async {
    final db = await database;
    return await db.insert('buttons', button);
  }

  // Get all buttons from the database
  Future<List<Map<String, dynamic>>> getAllButtons() async {
    final db = await database;
    return await db.query('buttons');
  }

  // Update a button
  Future<int> updateButton(int id, Map<String, dynamic> button) async {
    final db = await database;
    return await db.update(
      'buttons',
      button,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a button
  Future<int> deleteButton(int id) async {
    final db = await database;
    return await db.delete(
      'buttons',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Preference operations
  // ----------------------

  // Save a specific preference
  Future<void> setPreference(String key, dynamic value) async {
    final db = await database;

    // Upsert logic to replace if exists or insert if not
    await db.insert(
      'preferences',
      {'key': key, 'value': value.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all preferences as a Map
  Future<Map<String, dynamic>> getAllPreferences() async {
    final db = await database;

    final prefs = await db.query('preferences');
    return Map.fromEntries(
      prefs.map((e) => MapEntry(e['key'] as String, e['value'])),
    );
  }

  // Get a specific preference by key
  Future<String?> getPreference(String key) async {
    final db = await database;

    final result = await db.query(
      'preferences',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (result.isNotEmpty) {
      return result.first['value'] as String;
    }
    return null;
  }
}
