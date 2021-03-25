import 'dart:math';

import 'package:flutter/foundation.dart';

import 'cart.dart';

///Define um pedido composto por um ou mais produtos
class Order {
  ///Id do pedido
  final String id;

  ///Valor total do pedido
  final double total;

  ///Produtos comprados
  final List<CartItem> products;

  ///Data em que o pedido foi feito
  final DateTime date;

  ///Obtém o id, o total dos produtos, a data e os produtos de um pedido
  Order({
    this.id,
    this.total,
    this.date,
    this.products,
  });
}

///Agrupa todos os pedidos feitos, você só poderá criar um pedido através dele
// ignore: prefer_mixin
class Orders with ChangeNotifier {
  final List<Order> _items = [];

  ///Obtém uma cópia dos pedidos armazenados
  List<Order> get items => [..._items];

  ///Obtem a quantidade de pedidos
  int get itemsCount => _items.length;

  ///Adiciona um pedido
  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        products: cart.items.values.toList(),
        total: cart.totalAmount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}