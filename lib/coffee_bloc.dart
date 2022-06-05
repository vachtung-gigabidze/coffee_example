import 'package:flutter/material.dart';

const _initialPage = 8.0;

class CoffeeBLoC {
  final pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final pageTextController = PageController(initialPage: _initialPage.toInt());
  final currentPage = ValueNotifier<double>(_initialPage);
  final currentTextPage = ValueNotifier<double>(_initialPage);

  void init() {
    pageCoffeeController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textControllerListener);
  }

  void _textControllerListener() {
    currentTextPage.value = pageTextController.page!;
  }

  void _coffeeScrollListener() {
    currentPage.value = pageCoffeeController.page!;
  }

  void dispose() {
    pageCoffeeController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textControllerListener);
    pageTextController.dispose();
    pageCoffeeController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  CoffeeProvider({required this.bloc, required super.child});
  static CoffeeProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();
  final CoffeeBLoC bloc;
  @override
  bool updateShouldNotify(covariant CoffeeProvider oldWidget) => false;
}
