import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screen/category_screen.dart';
import 'package:meals/screen/meals_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    super.key,
  });
  // final Meal meals;
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // ignore: unused_field
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showMessage("Meal is no longer a favorite");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showMessage("Marked as Favorite");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavorite: (_toggleMealFavoriteStatus),
    );
    var activeTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activeTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
          ]),
    );
  }
}
