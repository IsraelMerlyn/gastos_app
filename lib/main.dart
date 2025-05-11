import 'package:flutter/material.dart';
import 'package:gastos_app/providers/transaction_provider.dart';
import 'package:gastos_app/screens/summary_screen.dart';
import 'package:gastos_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => TransactionProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme.copyWith(),
      home: SumaryScreen(),
    );
  }
}
