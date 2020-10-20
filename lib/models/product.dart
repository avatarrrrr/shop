import 'package:flutter/foundation.dart';

///Model que representa um produto
class Product {
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
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
}
