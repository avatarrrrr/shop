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
  List<Order> _orders;

  ///Obtém uma cópia dos pedidos armazenados
  List<Order> get orders => [..._orders];

  ///Adiciona um pedido
  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        products: cart.items.values,
        total: cart.totalAmount,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
