import 'dart:math';

import 'package:flutter/foundation.dart';
import 'product.dart';

///Classe que representa um item do carrinho
class CartItem {
  ///ID do produto no carrinho
  final String id;

  ///ID do produto
  final String productID;

  ///Nome do produto
  final String title;

  ///Quantidade a ser comprada
  final int quantity;

  ///Preço do produto
  final double price;

  ///Construtor que irá pegar essas dados, tudo será requerido
  CartItem({
    @required this.id,
    @required this.productID,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

///Classe que representa um carrinho
// ignore: prefer_mixin
class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  ///Obtem uma cópia dos items
  Map<String, CartItem> get items => {..._items};

  ///Retorna a quantidade de items no carrinho
  int get itemsCount => _items.length;

  ///Obtem o preço de totos os produtos no carrinho
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, itemCart) {
      total += itemCart.price * itemCart.quantity;
    });
    return total;
  }

  ///Adiciona um item no carrinho, se ele já tiver, aumenta sua quantidade
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
          id: existingItem.id,
          productID: product.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        );
      });
    } else {
      _items.putIfAbsent(product.id, () {
        return CartItem(
          id: Random().nextDouble().toString(),
          productID: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        );
      });
    }

    notifyListeners();
  }

  ///Remove um item do carrinho
  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }
}
