import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  Orders(this.token, this._orders);

  final String token;
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$token';
    final response = await http.get(Uri.parse(url));

    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price']))
              .toList()));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://shop-c13d2-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$token';

    try {
      final timestamp = DateTime.now();
      var response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity
                    })
                .toList()
          }));

      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              dateTime: timestamp,
              products: cartProducts));

      notifyListeners();
    } catch (error) {}
  }
}
