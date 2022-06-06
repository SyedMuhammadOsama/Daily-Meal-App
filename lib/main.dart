import '/dummy_data.dart';
import '/models/meals.dart';

import '/screens/filters_screen.dart';

import '/screens/meal_details_screen.dart';
import '/screens/tabs_screen.dart';

import 'screens/category_meals_screen.dart';
import 'screens/category_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> favoriteMeals = [];
  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilters(Map<String, bool> filtersData) {
    setState(() {
      filters = filtersData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose']! && !(meal.isLactoseFree)) {
          return false;
        }
        if (filters['vegetarian']! && !(meal.isVegetarian)) {
          return false;
        }
        if (filters['vegan']! && !(meal.isVegan)) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    var existingIndex = favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere(
        (meal) => meal.id == mealId,
      ));
    }
  }

  bool isFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Daily Meals",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      // home: const CategoryScreen(),
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailsScreen.routename: (ctx) =>
            MealDetailsScreen(toggleFavorite, isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFilters,
              filters,
            ),
      },
      onGenerateRoute: (settings) {
        //it renders when the required route is not registered in "routes".
        return MaterialPageRoute(
          builder: (ctx) => const CategoryScreen(),
        );
      },
      onUnknownRoute: (settings) {
        //it renders when "onGenereateRoute not working for some reasons, it is like a page we see when we enter some url on google and it shows error page like error 404 something..."
        return MaterialPageRoute(
          builder: (ctx) => const CategoryScreen(),
        );
      },
    );
  }
}
