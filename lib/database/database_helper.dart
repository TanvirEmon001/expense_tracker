import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_expense/models/balance_item_model.dart';
import 'package:track_expense/models/expense_item_model.dart';

class DatabaseHelper {
  static const int _dbVersion = 2;
  static const String _table1 = "expense_item";
  static const String _table2 = "balance_item";
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
    CREATE TABLE $_table1 (
        id        TEXT    PRIMARY KEY,
        itemName  TEXT    NOT NULL,
        balance   REAL    NOT NULL,
        dateTime  TEXT    NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE $_table2 (
        id        TEXT    PRIMARY KEY,
        itemId  TEXT    NOT NULL,
        title  TEXT    NOT NULL,
        updatedBalance   REAL    NOT NULL,
        isExpense   INTEGER  NOT NULL DEFAULT 0,
        dateTime  TEXT    NOT NULL
      )
    ''');
  }

  // --  Table - 1 CRUD
  Future<int> insertExpenseItem(ExpenseItemModel itemModel) async {
    final db = await database;

    return await db.insert(_table1, itemModel.toMap(), conflictAlgorithm: .replace);
  }


  Future<List<ExpenseItemModel>> getAllExpenseItem() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_table1, orderBy: "dateTime DESC");

    return List.generate(maps.length, (i) => ExpenseItemModel.fromMap(maps[i]));
  }


  Future<ExpenseItemModel?> getExpenseItemById(String id) async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_table1, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) return ExpenseItemModel.fromMap(maps.first);
    return null;
  }

  Future<int> updateExpenseItem(ExpenseItemModel itemModel) async {
    final db = await database;

    return await db.update(_table1, itemModel.toMap(), where: 'id = ?', whereArgs: [itemModel.id]);
  }

  Future<int> deleteExpenseItem(String id) async {
    final db = await database;
    
    return await db.delete(_table1, where: 'id = ?', whereArgs: [id]);
  }
  // -- Table - 1 - CRUD ends here

  // -- Table - 2 CRUD
  Future<int> insertBalanceItem(BalanceItemModel itemModel) async {
    final db = await database;

    return await db.insert(_table2, itemModel.toMap(), conflictAlgorithm: .replace);
  }

  Future<List<BalanceItemModel>> getAllBalanceItem() async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_table2, orderBy: "dateTime DESC");

    return List.generate(maps.length, (i) => BalanceItemModel.fromMap(maps[i]));
  }

  Future<List<BalanceItemModel>> getBalanceItemById(String itemId) async {
    final db = await database;
    final List<Map<String,dynamic>> maps = await db.query(_table2, where: 'itemId = ?', whereArgs: [itemId]);

    return maps.map((m) => BalanceItemModel.fromMap(m)).toList();

  }

  Future<int> updateBalanceItem(BalanceItemModel itemModel) async {
    final db = await database;

    return await db.update(_table2, itemModel.toMap(), where: 'id = ?', whereArgs: [itemModel.id]);
  }

  Future<int> deleteBalanceItem(String id) async {
    final db = await database;

    return await db.delete(_table2, where: 'id = ?', whereArgs: [id]);
  }

  // -- Table - 2 CRUD ends here

}