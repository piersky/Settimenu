import 'package:path/path.dart';
import 'package:settimenu/database/dish_model.dart';
import 'package:settimenu/utils/costants.dart';
import 'package:sqflite/sqflite.dart';

import 'menu_model.dart';

class DatabaseHelper {
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

    String path = join(await getDatabasesPath(), kDatabaseName);
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        print("DATABASE HELPER - onConfigure");
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    ); //, onUpgrade: _onUpgrade);
  }

  Future<void> initializeDatabase() async {
    print("DATABASE HELPER - initializeDatabase");
    await database;
  }

  Future _onCreate(Database db, int version) async {
    await createDishesTable(db);
    await createMenusTable(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("DATABASE HELPER - _onUpgrade");
    if (oldVersion < 1) {
      await createDishesTable(db);
      await createMenusTable(db);
    }
  }

  Future<void> createDishesTable(Database db) async {
    print("DATABASE HELPER - createDishesTable");
    await db.execute('''
      CREATE TABLE $kDishesTable (
        $kDishesTableId INTEGER PRIMARY KEY AUTOINCREMENT,
        $kDishesTableMenuId INTEGER NOT NULL,
        $kDishesTableName TEXT NOT NULL,
        $kDishesTableDescription TEXT,
        $kDishesTableImagePath TEXT,
        $kDishesTableMealType TEXT NOT NULL,
        $kDishesTableWeekday TEXT NOT NULL,
        $kDishesTableIsActive BOOLEAN NOT NULL DEFAULT 1,
        FOREIGN KEY ($kDishesTableMenuId) REFERENCES menus (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> createMenusTable(Database db) async {
    print("DATABASE HELPER - createMenusTable");
    await db.execute('''
      CREATE TABLE $kMenusTable (
        $kMenusTableId INTEGER PRIMARY KEY AUTOINCREMENT,
        $kMenusTableName TEXT NOT NULL,
        $kMenusTableDescription TEXT,
        $kMenusTableImageUrl TEXT,
        $kMenusTableIsActive BOOLEAN NOT NULL DEFAULT 1
      )
    ''');
  }

  Future<void> insertDish(DishModel dish) async {
    final db = await instance.database;
    await db.insert(
      kDishesTable,
      dish.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMenu(MenuModel menu) async {
    final db = await instance.database;
    await db.insert(
      kMenusTable,
      menu.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> queryAllTablesData() async {
    final db = await instance.database;
    final tablesQuery = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
    );

    Map<String, List<Map<String, dynamic>>> data = {};

    for (var table in tablesQuery) {
      final tableName = table['name'] as String;
      final tableData = await db.query(tableName);
      data[tableName] = tableData;
    }

    return data;
  }

  Future<void> deleteDatabase() async {
    print("DATABASE HELPER - deleteDatabase");
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, kDatabaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
