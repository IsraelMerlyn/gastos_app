import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:gastos_app/models/transaction.dart' as my_transaction;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        category TEXT,
        amount REAL,
        type TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.insert('transactions', transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<my_transaction.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (index) {
      return my_transaction.Transaction(
        id: maps[index]['id'],
        category: maps[index]['category'],
        amount: maps[index]['amount'],
        type: maps[index]['type'] == 'income'
            ? my_transaction.TransactionType.income
            : my_transaction.TransactionType.expense,
        date: DateTime.parse(maps[index]['date']),
      );
    });
  }

  Future<void> updateTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
