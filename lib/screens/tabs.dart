import 'package:flutter/material.dart';
import 'package:myapp/screens/categories.dart';
import 'package:myapp/models/meal.dart';
import 'package:myapp/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key,required this.onToggleFavorite});

    final void Function(Meal meal) onToggleFavorite;


  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selsectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
    }
  }

  void _selsectedPage(int index) {
    setState(() {
      _selsectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleFavorite,);
    var activePageTitle = 'Categories';

    if (_selsectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: [], 
        onToggleFavorite: _toggleFavorite);
      activePageTitle = 'Faviorites';
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selsectedPage,
        currentIndex: _selsectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites',),
        ],
      ),
    );
  }
}