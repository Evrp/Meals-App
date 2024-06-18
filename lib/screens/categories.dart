import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/meal.dart';
import 'package:myapp/widgets/category_grid_item.dart';
import 'package:myapp/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

    final void Function(Meal meal) onToggleFavorite;


  void _selectCategory(BuildContext context, Category category) {
    final filterMeals = dummyMeals
      .where((meal) => meal.categories.contains(category.id))
      .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filterMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context,category);
              },
            )
        ],
      );
  }
}
