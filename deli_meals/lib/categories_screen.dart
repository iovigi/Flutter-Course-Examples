import 'package:deli_meals/category_item.dart';
import 'package:flutter/material.dart';
import './dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DeliMeal'),
        ),
        body: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisExtent: 20),
            children: DUMMY_CATEGORIES
                .map((catData) =>
                    CategoryItem(title: catData.title, color: catData.color))
                .toList()));
  }
}
