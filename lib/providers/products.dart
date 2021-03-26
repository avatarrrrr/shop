import 'dart:math';

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
  void addProduct(Product newProduct) {
    _items.add(
      Product(
        id: Random().nextDouble().toString(),
        title: newProduct.title,
        price: newProduct.price,
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
      ),
    );
    notifyListeners();
  }

  ///Atualiza um produto
  void updateProduct(Product product) {
    if (product == null || product.id == null) return;
    final index =
        _items.indexWhere((productItem) => productItem.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  ///Remove um produto
  void deleteProduct(String id) {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
