import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FliterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            PopupMenuButton(
                onSelected: (FliterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FliterOptions.Favorites) {
                      _showOnlyFavorites = true;
                    } else {
                      _showOnlyFavorites = false;
                    }
                  });
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text('Only Favorites'),
                          value: FliterOptions.Favorites),
                      PopupMenuItem(
                          child: Text('Show All'), value: FliterOptions.All)
                    ],
                icon: Icon(Icons.more_vert))
          ],
        ),
        body: ProductsGrid(showOnlyFavorites: _showOnlyFavorites));
  }
}
