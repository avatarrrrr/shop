import 'package:flutter/foundation.dart';

///Model que representa um produto
// ignore: prefer_mixin
class Product with ChangeNotifier {
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
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
