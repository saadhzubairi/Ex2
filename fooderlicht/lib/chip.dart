import 'package:flutter/material.dart';
import 'package:fooderlicht/fooderlicht_theme.dart';

class Chipp extends StatelessWidget {
  const Chipp({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: FooderlichTheme.darkTextTheme.bodyText1),
      backgroundColor: Colors.grey.withOpacity(0.2),
      padding: const EdgeInsets.all(7),
      onDeleted: () {
        print("deleted");
      },
    );
  }
}
