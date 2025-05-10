import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = '';
  final List<String> _categories = [
    'Comida',
    'Transporte',
    'Entretenimiento',
    'Salud'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Transacción'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un monto';
                }
                return null;
              },
              decoration:  const InputDecoration(
                labelText: 'Monto',
                prefixIcon: Icon(Icons.attach_money),

              ),
            ),
            const SizedBox(height:20.0),
            TextFormField(
              controller: _descriptionController,

              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un monto';
                }
                return null;
              },
              decoration:  const InputDecoration(
                labelText: 'Descripcion',
                prefixIcon: Icon(Icons.attach_money),

              ),
            ),
            const SizedBox(height:20.0),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Categoría',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height:20.0),
            Center(
              child: ElevatedButton(onPressed: () {
                if(_formKey.currentState!.validate()){
                  // Aquí puedes agregar la lógica para guardar la transacción
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transacción guardada')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar Transacción'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),

        ),
      ),
    );
  }
}
