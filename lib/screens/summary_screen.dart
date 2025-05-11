import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/providers/transaction_provider.dart';
import 'package:gastos_app/screens/transaction_form_screen.dart';
import 'package:gastos_app/screens/transaction_history_screen.dart';
import 'package:gastos_app/widgets/expense_chart.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';

class SumaryScreen extends StatefulWidget {
  const SumaryScreen({super.key});

  @override
  State<SumaryScreen> createState() => _SumaryScreenState();
}

class _SumaryScreenState extends State<SumaryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    // final List<ExpenseData> expenseData = [
    //   ExpenseData('Comida', 100),
    //   ExpenseData('Transporte', 50),
    //   ExpenseData('Entretenimiento', 200),
    //   ExpenseData('Salud', 150),
    // ];
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    final totalIncome = transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final totalExpenses = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    return Scaffold(
        appBar: AppBar(
          title: Text('Resumen de Gastos'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.history_sharp),
              onPressed: () {
                // Navigator.pushNamed(context, '/settings');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ExpenseData) => TransactionHistoryScreen()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text(
              //   'Resumen del mes',
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.green,
                  ),
                  title: const Text('Ingresos'),
                  subtitle: Text('\$${totalIncome.toStringAsFixed(2)}'),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.red,
                  ),
                  title: const Text('Ingresos'),
                  subtitle: Text('\$${totalExpenses.toStringAsFixed(2)}'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionFormScreen()));
                  },
                  label: const Text(
                    'Agregar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.add_box_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
              ExpenseChart()
            ],
          ),
        ));
  }
}
