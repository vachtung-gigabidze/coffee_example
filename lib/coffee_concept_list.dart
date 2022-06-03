import 'package:coffee_example/coffee.dart';
import 'package:flutter/material.dart';

const _duration = Duration(microseconds: 500);

class CoffeeConceptList extends StatefulWidget {
  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
  );
  final _pageTextController = PageController();
  double? _currentPage = 0.0;
  double? _currentTextPage = 0.0;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page;
    });
  }

  void _textControllerListener() {
    _currentTextPage = _pageTextController.page;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_textControllerListener);
    _pageTextController.dispose();
    _pageCoffeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 45,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: Container(
                color: Colors.transparent,
              )),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length + 1,
                itemBuilder: (content, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = _currentPage! - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  //print(_currentPage);
                  //return Image.asset(coffee.image);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              0.0, size.height / 2.6 * (1 - value).abs())
                          ..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Image.asset(
                              coffee.image,
                              fit: BoxFit.fitHeight,
                            ))),
                  );
                }),
          ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: coffees.length,
                      controller: _pageTextController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (content, index) {
                        final opacity = (1 - (index - _currentTextPage!).abs())
                            .clamp(0.0, 1.0);
                        return Opacity(
                          opacity: opacity,
                          child: Text(
                            coffees[index].name,
                          ),
                        );
                      },
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: _duration,
                    child: Text(
                      '\$${coffees[_currentPage!.toInt()].price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                      key: Key(coffees[_currentPage!.toInt()].name),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
