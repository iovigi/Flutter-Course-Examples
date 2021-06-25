import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
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

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products.json';

    try {
      final result = await http.get(Uri.parse(url));
      final extractedData = json.decode(result.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future addProduct(Product product) async {
    const url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    try {
      var result = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
            'price': product.price
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

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((element) => element.id == id);

    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;

      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((value) => value.id == id);

    notifyListeners();
  }
}
