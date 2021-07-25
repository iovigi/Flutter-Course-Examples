import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  Products(this.token, this.userId, this._items);

  final String token;
  final String userId;
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts([filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token&$filterString';

    try {
      final result = await http.get(Uri.parse(url));
      final extractedData = json.decode(result.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      url =
          'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$token';

      final favorite = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favorite.body) as Map<String, dynamic>;

      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId]['isFavorite'] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future addProduct(Product product) async {
    final url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token';
    try {
      var result = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId
          }));
      _items.add(Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(result.body)['name']));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json??auth=$token';

      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));

      _items[prodIndex] = newProduct;

      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token';

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
