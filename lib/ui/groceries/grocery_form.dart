import 'package:flutter/material.dart';

import '../../models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {

  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    setState(() {
      _selectedCategory = defaultCategory;
      _nameController.text = defaultName;
      _quantityController.text = defaultQuantity.toString();
    });
  }

  void onAdd() {
    if (!_formKey.currentState!.validate()) return;

    final newGrocery = Grocery(
      id: DateTime.now().toString(),
      name: _nameController.text.trim(),
      quantity: int.parse(_quantityController.text),
      category: _selectedCategory,
    );

    Navigator.of(context).pop(newGrocery);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: InputDecoration(
                label: const Text('Name'),
                counterText: '',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Quantity'),
        
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    value: _selectedCategory,
                    items: GroceryCategory.values.map((cat) {
                      return DropdownMenuItem<GroceryCategory>(
                        value: cat,
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: cat.color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            Text(cat.label.toLowerCase()),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
