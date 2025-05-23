import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/screens/transaction_form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Transacciones'),
        centerTitle: true,
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text('No hay transaccion Registrada'),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(
                      transaction.type == TransactionType.income
                          ? Icons.arrow_circle_up
                          : Icons.arrow_circle_down,
                      color: transaction.type == TransactionType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(transaction.category),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction.date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      '\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: transaction.type == TransactionType.income
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionFormScreen(
                                    transaction: transaction,
                                  )));
                    },
                    onLongPress: () {
                      transactionProvider.deleteTransaction(transaction.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Transacción eliminada'),
                          action: SnackBarAction(
                            label: 'Deshacer',
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
