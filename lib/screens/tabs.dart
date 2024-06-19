import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/categories.dart';
import 'package:myapp/screens/filter.dart';
import 'package:myapp/screens/meals.dart';
import 'package:myapp/widgets/main_drawer.dart';
import 'package:myapp/providers/favorites_provider.dart';
import 'package:myapp/providers/filter_provider.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({
    super.key, 
  });

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selsectedPageIndex = 0;

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if (identifier == 'filters') {      
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  void _selsectedPage(int index) {
    setState(() {
      _selsectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      );

    var activePageTitle = 'Categories';

    if (_selsectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals, 
        );
      activePageTitle = 'Your Faviorites';
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen:_setScreen),
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