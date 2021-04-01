import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
  final _baseUrl = Uri.parse(
      'https://shop-project-9673b-default-rtdb.firebaseio.com/orders');
  final List<Order> _items = [];

  ///Obtém uma cópia dos pedidos armazenados
  List<Order> get items => [..._items];

  ///Obtem a quantidade de pedidos
  int get itemsCount => _items.length;

  ///Adiciona um pedido
  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${_baseUrl.toString()}.json'),
      body: json.encode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productID,
                    'title': cartItem.title,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        },
      ),
    );

    _items.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        products: cart.items.values.toList(),
        total: cart.totalAmount,
        date: date,
      ),
    );
    notifyListeners();
  }
}
