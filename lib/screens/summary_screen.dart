import 'package:flutter/material.dart';

class SumaryScreen extends StatelessWidget {
  const SumaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resumen de Gastos'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Resumen del mes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.green,
                  ),
                  title: Text('Ingresos'),
                  subtitle: Text('\$0.0'),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.arrow_upward_outlined,
                    color: Colors.red,
                  ),
                  title: Text('Ingresos'),
                  subtitle: Text('\$0.0'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: Text('Agregar'),
                  icon: Icon(Icons.add_box_rounded),
                ),
              ),
            ],
          ),
        ));
  }
}
