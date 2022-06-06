import 'package:flutter/material.dart';
import 'package:daily_meals_app/dummy_data.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routename = '/MealDetails';
  final void Function(String) toggleFunction;
  final bool Function(String) isFavorite;
  MealDetailsScreen(this.toggleFunction, this.isFavorite);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final mealId = routeArgs['mealId'];

    final selectedMeal = DUMMY_MEALS.firstWhere(
      (meal) {
        return meal.id == mealId;
      },
    );

    Widget buildSectionTitle(BuildContext ctx, String title) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Text(title, style: Theme.of(context).textTheme.headline1),
      );
    }

    Widget buildSectionContainer(child) {
      return Container(
        height: 150,
        width: 300,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildSectionContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildSectionContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text('# ${index + 1}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //we can't use more than two floating action buttons
      // to use it comment out below button
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(mealId);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          setState(() {
            widget.toggleFunction(mealId!);
          });
        },
        child: widget.isFavorite(mealId!)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
