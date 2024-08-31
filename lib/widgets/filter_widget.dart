import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/product_category.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final TextEditingController controllerPriceMin = TextEditingController();
  final TextEditingController controllerPriceMax = TextEditingController();
  ProductCategory? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Flexible(
                child: TextFormField(
                    controller: controllerPriceMin,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'Min.'),
                    validator: (value) => (value!.isNotEmpty &&
                            double.tryParse(value.trim()) == null)
                        ? 'Enter a valid number'
                        : null)),
            const SizedBox(width: 20),
            Flexible(
                child: TextFormField(
                    controller: controllerPriceMax,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'Max.'),
                    validator: (value) => (value!.isNotEmpty &&
                            double.tryParse(value.trim()) == null)
                        ? 'Enter a valid number'
                        : null))
          ]),
          const SizedBox(height: 20),
          const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<ProductCategory>(
              value: category,
              items: ProductCategory.dropDownItems,
              hint: const Text('Choose category'),
              icon: const Icon(Icons.category),
              onChanged: (categoryChose) =>
                  setState(() => category = categoryChose)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              onPressed: () {
                double? min = double.tryParse(controllerPriceMin.text);
                double? max = double.tryParse(controllerPriceMax.text);
                context.go('/filtered-products/$min/$max/${category?.name}');
                Navigator.pop(context);
              },
              label: const Text('Apply'),
              icon: const Icon(Icons.tune))
        ]));
  }
}
