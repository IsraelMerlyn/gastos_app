import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/providers/transaction_provider.dart';
import 'package:gastos_app/screens/transaction_form_screen.dart';
import 'package:gastos_app/screens/transaction_history_screen.dart';
import 'package:gastos_app/widgets/expense_chart.dart';
import 'package:provider/provider.dart';

// import '../models/expense_data.dart'; // Comentado si no se usa directamente aquí

class SumaryScreen extends StatefulWidget {
  const SumaryScreen({super.key});

  @override
  State<SumaryScreen> createState() => _SumaryScreenState();
}

class _SumaryScreenState extends State<SumaryScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar transacciones al iniciar la pantalla
    // Usar addPostFrameCallback para asegurar que el contexto esté disponible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false)
          .loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen Financiero'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          final transactions = transactionProvider.transactions;

          final totalIncome = transactions
              .where(
                  (transaction) => transaction.type == TransactionType.income)
              .fold(0.0, (sum, transaction) => sum + transaction.amount);

          final totalExpenses = transactions
              .where(
                  (transaction) => transaction.type == TransactionType.expense)
              .fold(0.0, (sum, transaction) => sum + transaction.amount);

          final balance = totalIncome - totalExpenses;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Estirar hijos
                children: [
                  _buildSummaryCard(
                    title: 'Ingresos Totales',
                    amount: totalIncome,
                    icon: Icons.arrow_downward_outlined,
                    color: Colors.green,
                    context: context,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryCard(
                    title: 'Gastos Totales',
                    amount: totalExpenses,
                    icon: Icons.arrow_upward_outlined,
                    color: Colors.red,
                    context: context,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryCard(
                    title: 'Balance General',
                    amount: balance,
                    icon: Icons.account_balance_wallet_outlined,
                    color: balance >= 0 ? Colors.blue : Colors.orange,
                    context: context,
                  ),
                  const SizedBox(height: 24),
                  if (transactions
                      .where((t) => t.type == TransactionType.expense)
                      .isNotEmpty)
                    const Text(
                      'Distribución de Gastos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  if (transactions
                      .where((t) => t.type == TransactionType.expense)
                      .isNotEmpty)
                    SizedBox(
                      height: 200, // Ajusta la altura según sea necesario
                      child: ExpenseChart(),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionFormScreen(),
            ),
          );
        },
        label: const Text('Agregar'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
    required BuildContext context,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
