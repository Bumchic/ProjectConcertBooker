import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concertbooker/app_state.dart';

class CreateConcertScreen extends StatefulWidget {
  const CreateConcertScreen({super.key});

  @override
  State<CreateConcertScreen> createState() => _CreateConcertScreenState();
}

class _CreateConcertScreenState extends State<CreateConcertScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = TextEditingController();
  final _rowsController = TextEditingController();
  final _colsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    _rowsController.dispose();
    _colsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AppState>().addConcert(
      _nameController.text.trim(),
      _imageController.text.trim(),
      int.parse(_rowsController.text),
      int.parse(_colsController.text),
      _dateController.text.trim(),
      double.parse(_priceController.text),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Concert created successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Concert')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _textField(
                controller: _nameController,
                label: 'Concert Name',
                icon: Icons.event,
                validator: _required,
              ),
              const SizedBox(height: 16),

              _textField(
                controller: _imageController,
                label: 'Image URL',
                icon: Icons.image,
                validator: _required,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _textField(
                      controller: _dateController,
                      label: 'Date',
                      icon: Icons.calendar_today,
                      validator: _required,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _textField(
                      controller: _priceController,
                      label: 'Price',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: _numberRequired,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _textField(
                      controller: _rowsController,
                      label: 'Rows',
                      icon: Icons.table_rows,
                      keyboardType: TextInputType.number,
                      validator: _seatValidator,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _textField(
                      controller: _colsController,
                      label: 'Columns',
                      icon: Icons.view_column,
                      keyboardType: TextInputType.number,
                      validator: _seatValidator,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('CREATE CONCERT'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  String? _numberRequired(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (double.tryParse(value) == null) return 'Invalid number';
    return null;
  }

  String? _seatValidator(String? value) {
    final n = int.tryParse(value ?? '');
    if (n == null || n < 1 || n > 50) return '1 - 50';
    return null;
  }
}
