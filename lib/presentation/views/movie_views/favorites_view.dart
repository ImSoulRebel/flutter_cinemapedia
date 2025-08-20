import 'package:flutter/material.dart';

class FavouritesView extends StatelessWidget {
  static const name = 'favourites-view';

  const FavouritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FavoritesView')),
      body: Center(child: Text('FavoritesView')),
    );
  }
}
