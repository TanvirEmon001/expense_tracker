import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_expense/models/expense_item_model.dart';

class DatabaseHelper {
  static const int _dbVersion = 1;
  static const String _tableName = "expense_item";
  static const String _dbName = "expense_item.db";
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;


  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
        id        TEXT    PRIMARY KEY,
        itemName  TEXT    NOT NULL,
        balance   REAL    NOT NULL,
        dateTime  TEXT    NOT NULL
      )
    ''');
  }

  Future<int> insertExpenseItem(ExpenseItemModel itemModel) async {
    final db = await database;

    return await db.insert(_tableName, itemModel.toMap(), conflictAlgorithm: .replace);
  }


  Future<List<ExpenseItemModel>> getAllExpenseItem() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_tableName, orderBy: "dateTime DESC");

    return List.generate(maps.length, (i) => ExpenseItemModel.fromMap(maps[i]));
  }


  Future<ExpenseItemModel?> getExpenseItemById(String id) async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) return ExpenseItemModel.fromMap(maps.first);
    return null;
  }

  Future<int> updateExpenseItem(ExpenseItemModel itemModel) async {
    final db = await database;

    return await db.update(_tableName, itemModel.toMap(), where: 'id = ?', whereArgs: [itemModel.id]);
  }

  Future<int> deleteExpenseItem(String id) async {
    final db = await database;
    
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

}