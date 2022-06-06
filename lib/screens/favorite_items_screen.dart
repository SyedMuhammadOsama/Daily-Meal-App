import '/models/meals.dart';
import '/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class FavoriteItemsScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoriteItemsScreen(this.favoriteMeals);

  Widget build(BuildContext context) {
    return (favoriteMeals.isEmpty)
        ? Center(
            child: Text(
              'I am your favorite Screen! But I\'m empty!',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                  id: favoriteMeals[index].id,
                  title: favoriteMeals[index].title,
                  imageUrl: favoriteMeals[index].imageUrl,
                  duration: favoriteMeals[index].duration,
                  complexity: favoriteMeals[index].complexity,
                  affordability: favoriteMeals[index].affordability,
                  removeMeal: () {});
            },
            itemCount: favoriteMeals.length,
          );
  }
}
