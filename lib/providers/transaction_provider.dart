import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/services/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Transaction> get transactions => _transactions;

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
    await _dbHelper.insertTransaction(transaction);
    notifyListeners();
  }

  void deleteTransaction(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await _dbHelper.deleteTransaction(id);
    notifyListeners();
  }

  void updateTransaction(Transaction transaction) async {
    int index =
        _transactions.indexWhere((element) => element.id == transaction.id);
    _transactions[index] = transaction;
    await _dbHelper.updateTransaction(transaction);
    notifyListeners();
  }
}
