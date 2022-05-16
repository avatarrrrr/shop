import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'cart.dart';

///Define um pedido composto por um ou mais produtos
class Order {
  ///Id do pedido
  final String? id;

  ///Valor total do pedido
  final double? total;

  ///Produtos comprados
  final List<CartItem>? products;

  ///Data em que o pedido foi feito
  final DateTime? date;

  ///Obtém o id, o total dos produtos, a data e os produtos de um pedido
  Order({
    this.id,
    this.total,
    this.date,
    this.products,
  });
}

///Agrupa todos os pedidos feitos, você só poderá criar um pedido através dele
class Orders extends ChangeNotifier {
  final _baseUrl = Uri.parse('${Constants.baseApiURL}/orders');
  final String? _token;
  final String? _userID;

  List<Order> _items;

  ///Recebe token pra fazer as alterações no banco, também uma lista de order.
  Orders(this._token, this._userID, this._items);

  ///Obtém uma cópia dos pedidos armazenados
  List<Order> get items => [..._items];

  ///Obtem a quantidade de pedidos
  int get itemsCount => _items.length;

  ///Adiciona um pedido
  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${_baseUrl.toString()}/$_userID.json?auth=$_token'),
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

  ///Carrega os pedidos que estão no banco de dados
  Future<void> loadOrders() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$_userID.json?auth=$_token'));
    Map<String, dynamic>? data = json.decode(response.body);
    _items.clear();
    if (data != null) {
      data.forEach(
        (orderId, orderData) => _items.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    productID: item['productID'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ),
                )
                .toList(),
          ),
        ),
      );
      notifyListeners();
    }
    _items = _items.reversed.toList();
    return Future.value();
  }
}
