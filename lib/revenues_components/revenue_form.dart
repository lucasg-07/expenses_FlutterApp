import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/revenue.dart';
import '../revenue_provider.dart';
import '../transactions_components/adaptative_button.dart';
import '../transactions_components/adaptative_date_picker.dart';
import '../transactions_components/adaptative_text_field.dart';

class RevenueForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const RevenueForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<RevenueForm> createState() => _RevenueFormState();
}

class _RevenueFormState extends State<RevenueForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    final revenueProvider =
        Provider.of<RevenueProvider>(context, listen: false);

    final newRevenue = Revenue(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: _selectedDate!,
    );

    revenueProvider.addRevenue(newRevenue);

    // Limpe os campos do formulário após a adição
    _titleController.clear();
    _valueController.clear();
    setState(() {
      _selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                label: 'Título',
                controller: _titleController,
                onSubmitted: (_) => _submitForm,
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) {
                  final text = _valueController.text;
                  final modifiedText = text.replaceAll(',', '.');
                  _valueController.text = modifiedText;
                  _submitForm();
                },
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    'Novo ganho',
                    _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
