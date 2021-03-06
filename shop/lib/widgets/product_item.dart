import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context, listen: false);

    return Consumer<Product>(
      builder: (ctx, product, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                      arguments: product.id);
                },
                child: Image.network(product.imageUrl, fit: BoxFit.cover)),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  print(auth.userId);
                  product.toggleFavoriteStatus(auth.token, auth.userId);
                },
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          'Added item to cart!',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            })),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
