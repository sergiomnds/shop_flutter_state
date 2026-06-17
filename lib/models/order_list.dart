import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/order.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get orders => [..._items];

  int get itemCount => _items.length;

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
