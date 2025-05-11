import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseChart extends StatelessWidget {
  final List<ExpenseData> expenseData;
  const ExpenseChart({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    final exponses = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .toList();
    final Map<String, double> categoryTotals = {};

    for (var transaction in exponses) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    List<charts.Series<MapEntry<String, double>, String>> series = [
      charts.Series(
        id: 'Gastos',
        data: categoryTotals.entries.toList(),
        domainFn: (MapEntry<String, double> entry, _) => entry.key,
        measureFn: (MapEntry<String, double> entry, _) => entry.value,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: 300,
      child: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          charts.ChartTitle('Gastos por Categoria',
              behaviorPosition: charts.BehaviorPosition.top,
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea),
          charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
            horizontalFirst: false,
            desiredMaxRows: 2,
          ),
        ],
      ),
    );
  }
}
