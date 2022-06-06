import 'package:flutter/material.dart';

import '/screens/tabs_screen.dart';
import '/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      String title, IconData icon, VoidCallback navigationHandler) {
    return ListTile(
      onTap: navigationHandler,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 23,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Let"s Cook!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          const Divider(),
          buildListTile('Filters', Icons.filter, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
          const Divider(),
        ],
      ),
    );
  }
}
