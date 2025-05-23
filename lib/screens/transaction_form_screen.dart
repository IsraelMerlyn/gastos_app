// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionFormScreen extends StatefulWidget {
  final Transaction? transaction;
  const TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Comida';
  TransactionType _selectedType = TransactionType.expense;

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  prefixIcon: Icon(Icons.description_rounded),
                ),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripcion';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  prefixIcon: Icon(Icons.category),
                ),
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Gastos'),
                      value: TransactionType.expense,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          // Aquí puedes manejar el cambio de tipo de transacción
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Ingresos'),
                      value: TransactionType.income,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          // Aquí puedes manejar el cambio de tipo de transacción
                          _selectedType = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // Aquí puedes agregar la lógica para guardar la transacción
                    //   final newTransaction = Transaction(
                    //       id: const Uuid().v4(),
                    //       category: _selectedCategory,
                    //       amount: double.parse(_amountController.text),
                    //       type: _selectedType,
                    //       date: DateTime.now());

                    //   Provider.of<TransactionProvider>(context, listen: false)
                    //       .addTransaction(newTransaction);

                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Transacción guardada')),
                    //   );
                    //   Navigator.pop(context);
                    // }
                    if (_formKey.currentState!.validate()) {
                      final transactionProvider =
                          Provider.of<TransactionProvider>(context,
                              listen: false);
                      if (widget.transaction == null) {
                        transactionProvider.addTransaction(
                          Transaction(
                            id: const Uuid().v4(),
                            category: _selectedCategory,
                            amount: double.parse(_amountController.text),
                            type: _selectedType,
                            date: DateTime.now(),
                          ),
                        );
                      } else {
                        widget.transaction!.category = _selectedCategory;
                        widget.transaction!.amount =
                            double.parse(_amountController.text);
                        widget.transaction!.type = _selectedType;
                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        transactionProvider.notifyListeners();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(widget.transaction == null
                              ? 'Transacción guardada'
                              : 'Transacción actualizada'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.transaction == null
                        ? 'Guardar Transacción'
                        : 'Actualizar Transacción',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
