import '/dummy_data.dart';
import '/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'categoryMeals';

  final List<Meal> filteredMeals;
  CategoryMealsScreen(this.filteredMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String? categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    //it is ued instead of initState function when we have'of(context)' in the function
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    categoryMeals = widget.filteredMeals.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    super.didChangeDependencies();
  }

  void removeMealItem(String item) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
              removeMeal: removeMealItem);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
