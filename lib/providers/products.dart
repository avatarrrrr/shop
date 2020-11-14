import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';

///Classe que encapsulará a lista de produtos
// ignore: prefer_mixin
class Products with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  ///Retorna uma cópia da lista de produtos
  List<Product> get items => [..._items];

  ///Função para adicionar um produto
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
