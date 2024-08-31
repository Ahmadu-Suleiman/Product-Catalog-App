import 'package:flutter/material.dart';

enum ProductCategory {
  food('food'),
  clothing('clothing'),
  vehicle('vehicle'),
  books('books'),
  electronics('electronics');

  final String name;

  const ProductCategory(this.name);

  static List<DropdownMenuItem<ProductCategory>> get dropDownItems =>
      ProductCategory.values
          .map((category) =>
              DropdownMenuItem(value: category, child: Text(category.name)))
          .toList();

  static ProductCategory? category(String? categoryString) {
    for (var category in ProductCategory.values) {
      if (categoryString == category.name) return category;
    }
    return null;
  }
}
