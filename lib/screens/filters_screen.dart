import 'package:daily_meals_app/models/meals.dart';

import '/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filtersScreen';

  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  initState() {
    glutenFree = widget.currentFilters['gluten']!;
    lactoseFree = widget.currentFilters['lactose']!;
    vegan = widget.currentFilters['vegan']!;
    vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subTitle, bool currentValue,
      void Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  Map<String, bool> selectedFilters = {
                    'gluten': glutenFree,
                    'lactose': lactoseFree,
                    'vegetarian': vegetarian,
                    'vegan': vegan,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meals value',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
                child: ListView(children: [
              buildSwitchListTile(
                  'GlutenFree', 'Only includes gluten free foods', glutenFree,
                  (newValue) {
                setState(() {
                  glutenFree = newValue;
                });
              }),
              buildSwitchListTile('Lactose Free',
                  'Only includes lactose free foods', lactoseFree, (newValue) {
                setState(() {
                  lactoseFree = newValue;
                });
              }),
              buildSwitchListTile(
                  'vegetarian', 'Only includes vegetarian foods', vegetarian,
                  (newValue) {
                setState(() {
                  vegetarian = newValue;
                });
              }),
              buildSwitchListTile('vegan', 'Only includes vegan foods', vegan,
                  (newValue) {
                setState(() {
                  vegan = newValue;
                });
              })
            ]))
          ],
        ));
  }
}
