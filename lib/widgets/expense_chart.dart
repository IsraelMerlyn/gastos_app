import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import '../models/expense_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseChart extends StatelessWidget {
  final List<ExpenseData> expenseData;
  const ExpenseChart({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenseData , String>> series = [
      charts.Series(
        id: 'Expenses',
        data: expenseData,
        domainFn: (ExpenseData data, _) => data.category,
        measureFn: (ExpenseData data, _) => data.amomount,
        colorFn: (_,__ ) =>
            charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return  Container(
      padding: EdgeInsets.all(20.0),
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
