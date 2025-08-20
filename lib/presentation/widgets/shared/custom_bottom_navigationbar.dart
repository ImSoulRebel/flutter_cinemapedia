import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  static const List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_max)),
    BottomNavigationBarItem(
      label: 'Categorías',
      icon: Icon(Icons.label_outline),
    ),
    BottomNavigationBarItem(
      label: 'Favoritos',
      icon: Icon(Icons.favorite_border_outlined),
    ),
  ];

  int getLocationIndex(BuildContext context) {
    /// Extraer el path de la [location] actual
    final String location = GoRouterState.of(context).matchedLocation;
    return switch (location) {
      '/' => 0,
      '/categories' => 1,
      '/favourites' => 2,
      _ => 0,
    };
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');

        break;
      case 2:
        context.go('/favourites');
        break;
      default:
        context.go('/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getLocationIndex(context),
      onTap: (index) => onItemTapped(context, index),
      items: items,
    );
  }
}
