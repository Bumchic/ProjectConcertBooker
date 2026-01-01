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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageLinkController = TextEditingController();
  final TextEditingController _rowsController = TextEditingController();
  final TextEditingController _columnsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageLinkController.dispose();
    _rowsController.dispose();
    _columnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Concert'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Concert Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter concert name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imageLinkController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'https://example.com/image.jpg',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter image URL';
                  }
                  if (!Uri.tryParse(value.trim())!.isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _rowsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Number of Rows',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final n = int.tryParse(value);
                        if (n == null || n < 1 || n > 50) {
                          return '1 - 50';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _columnsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Seats per Row',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final n = int.tryParse(value);
                        if (n == null || n < 1 || n > 50) {
                          return '1 - 50';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String name = _nameController.text.trim();
                    final String imageLink = _imageLinkController.text.trim();
                    final int rows = int.parse(_rowsController.text);
                    final int columns = int.parse(_columnsController.text);

                    context.read<AppState>().addConcert(name, imageLink, rows, columns);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Concert created successfully!')),
                    );

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'CREATE CONCERT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}