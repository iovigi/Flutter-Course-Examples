import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> meals;

  FavoritesScreen({this.meals});

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    }

    return ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = meals[index];
        return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability);
      },
      itemCount: meals.length,
    );
  }
}
