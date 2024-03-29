import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

///Model que representa um produto
class Product extends ChangeNotifier {
  ///Identificador do produto
  final String id;

  ///Título
  final String title;

  ///Descrição
  final String description;

  ///Preço
  final double price;

  ///URL da imagem do produto
  final String imageUrl;

  ///Se o produto foi favoritado
  bool isFavorite;

  ///Construtor
  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  ///Inverte o valor do booleano isFavorite e notifca os observers
  Future<void> toggleFavorite(String token, String userID) async {
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(
      Uri.parse(
          '${Constants.baseApiURL}/userFavorites/$userID/$id.json?auth=$token'),
      body: json.encode(isFavorite),
    );
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Houve um erro ao favoritar este produto!');
    }
  }
}
