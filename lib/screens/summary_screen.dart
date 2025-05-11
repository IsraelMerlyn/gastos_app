import 'package:flutter/material.dart';
import 'package:gastos_app/screens/transaction_form_screen.dart';
import 'package:gastos_app/screens/transaction_history_screen.dart';
import 'package:gastos_app/widgets/expense_chart.dart';

import '../models/expense_data.dart';

class SumaryScreen extends StatelessWidget {
  const SumaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ExpenseData> expenseData = [
      ExpenseData('Comida', 100),
      ExpenseData('Transporte', 50),
      ExpenseData('Entretenimiento', 200),
      ExpenseData('Salud', 150),
    ];
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
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.green,
                  ),
                  title: Text('Ingresos'),
                  subtitle: Text('\$0.0'),
                ),
              ),
              const SizedBox(height: 20),
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.red,
                  ),
                  title: Text('Ingresos'),
                  subtitle: Text('\$0.0'),
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
              ExpenseChart(expenseData: expenseData)
            ],
          ),
        ));
  }
}
