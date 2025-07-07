import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int dbVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    print("DATABASE HELPER - _initDatabase");

    String path = join(await getDatabasesPath(), 'settimenu.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> initializeDatabase() async {
    print("DATABASE HELPER - initializeDatabase");
    await database;
  }

  Future _onCreate(Database db, int version) async {
    await createDishesTable(db);
    await createMenusTable(db);
  }

  Future<void> createDishesTable(Database db) async {
    print("DATABASE HELPER - createMealsTable");
    await db.execute('''
      CREATE TABLE dishes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        manu_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        image TEXT,
        meal TEXT NOT NULL,
        weekday TEXT NOT NULL
      )
    ''');
  }

  Future<void> createMenusTable(Database db) async {
    print("DATABASE HELPER - createMenusTable");
    await db.execute('''
      CREATE TABLE menus (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      )
    ''');
  }
}
