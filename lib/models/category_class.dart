import 'package:flutter/material.dart';

class CategoryClass {
  final String id;
  final String title;
  final Color color;

  const CategoryClass(
      {required this.id, required this.title, this.color = Colors.orange});
}
