import 'package:app/src/resources/theme/colors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {super.key,
      this.floatingActionButtonLocation =
          FloatingActionButtonLocation.centerDocked,
      this.shape = const CircularNotchedRectangle()});
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final NotchedShape? shape;
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: LightColors.kDarkYellow,
      child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  tooltip: 'Open navigation Menu',
                  icon: const Icon(Icons.home)),
              if (centerLocations.contains(floatingActionButtonLocation))
                const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/TextTest');
                },
                tooltip: 'Search',
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/albums');
                },
                icon: const Icon(Icons.favorite),
                tooltip: 'Favorite',
              )
            ],
          )),
    );
  }
}
