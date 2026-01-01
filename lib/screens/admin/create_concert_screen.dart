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

  // Các controller quản lý nhập liệu
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageLinkController = TextEditingController();
  final TextEditingController _rowsController = TextEditingController();
  final TextEditingController _columnsController = TextEditingController();

  // MỚI THÊM: Controller cho Ngày và Giá
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageLinkController.dispose();
    _rowsController.dispose();
    _columnsController.dispose();
    // MỚI THÊM: Dispose controller mới để tránh rò rỉ bộ nhớ
    _dateController.dispose();
    _priceController.dispose();
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
              // 1. Tên concert
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Concert Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter concert name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. Link ảnh
              TextFormField(
                controller: _imageLinkController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'https://example.com/image.jpg',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Ngày tổ chức và Giá vé (MỚI THÊM)
              Row(
                children: [
                  // Nhập ngày
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'e.g. 20/12/2025',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nhập giá
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price (\$)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 4. Số hàng và số cột ghế
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _rowsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Rows',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.table_rows),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        final n = int.tryParse(value);
                        if (n == null || n < 1 || n > 50) return '1-50';
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
                        labelText: 'Cols',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.view_column),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        final n = int.tryParse(value);
                        if (n == null || n < 1 || n > 50) return '1-50';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 5. Nút tạo concert
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lấy dữ liệu từ các controller
                    final String name = _nameController.text.trim();
                    final String imageLink = _imageLinkController.text.trim();
                    final int rows = int.parse(_rowsController.text);
                    final int columns = int.parse(_columnsController.text);

                    // Lấy dữ liệu mới (Date & Price)
                    final String date = _dateController.text.trim();
                    final double price = double.parse(_priceController.text);

                    // Gọi hàm addConcert với đầy đủ 6 tham số
                    context.read<AppState>().addConcert(
                        name,
                        imageLink,
                        rows,
                        columns,
                        date,
                        price
                    );

                    // Thông báo thành công và quay lại
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