import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';

class TransactionProvider with ChangeNotifier{
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }


  void deleteTransaction(String id){
    _transactions.removeWhere((transaction) => transaction.id == id);
    notifyListeners();
  }
}