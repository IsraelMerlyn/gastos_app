import 'package:flutter/material.dart';
import 'package:gastos_app/screens/summary_screen.dart';
import 'package:gastos_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: SumaryScreen(
    ),
    );
  }
}
