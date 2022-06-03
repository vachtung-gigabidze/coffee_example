import 'package:coffee_example/coffee_concept_list.dart';
import 'package:flutter/material.dart';

class MainCoffeeConceptApp extends StatelessWidget {
  const MainCoffeeConceptApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Theme(data: ThemeData.light(), child: CoffeeConceptList()));
  }
}
