import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'product.dart';

///Classe que encapsulará a lista de produtos
// ignore: prefer_mixin
class Products with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  ///Retorna uma cópia da lista de produtos
  List<Product> get items {
    return [..._items];
  }

  ///Retorna o número de produtos
  int get itemsCount => _items.length;

  ///Retorna uma cópia somente dos produtos favoritos
  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  ///Função para adicionar um produto
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
