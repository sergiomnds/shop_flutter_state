import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/exceptions/http_exception.dart';
import 'package:shop_flutter/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _localToggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _localToggleFavorite();
      final response = await http.put(
        Uri.parse('${Constants.userFavoriteUrl}/$userId/$id.json?auth=$token'),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _localToggleFavorite();
        throw HttpExceptionExample(
          msg: 'Não foi possível marcar como favorito',
          statusCode: response.statusCode,
        );
      }
    } catch (_) {
      _localToggleFavorite();
    }
  }
}
