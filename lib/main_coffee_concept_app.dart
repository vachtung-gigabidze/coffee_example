import 'package:coffee_example/coffee_bloc.dart';
import 'package:coffee_example/coffee_concept_home.dart';
import 'package:flutter/material.dart';

class MainCoffeeConceptApp extends StatefulWidget {
  const MainCoffeeConceptApp({Key? key}) : super(key: key);

  @override
  State<MainCoffeeConceptApp> createState() => _MainCoffeeConceptAppState();
}

class _MainCoffeeConceptAppState extends State<MainCoffeeConceptApp> {
  final bloc = CoffeeBLoC();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData.light(),
        child: CoffeeProvider(
          bloc: bloc,
          child: MaterialApp(home: CoffeeConceptHome()),
        ),
      ),
    );
  }
}
