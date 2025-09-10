import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  static const List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_max)),
    BottomNavigationBarItem(
      label: 'Populares',
      icon: Icon(Icons.thumbs_up_down_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Favoritos',
      icon: Icon(Icons.favorite_outlined),
    ),
  ];

  int getLocationIndex(BuildContext context) {
    /// Extraer el path de la [location] actual
    final String location = GoRouterState.of(context).matchedLocation;
    return switch (location) {
      '/' => 0,
      '/popular' => 1,
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
        context.go('/popular');
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
