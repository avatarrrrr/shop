import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';
import '../exceptions/http_exception.dart';
import 'product.dart';

///Classe que encapsulará a lista de produtos
// ignore: prefer_mixin
class Products with ChangeNotifier {
  final _baseUrl = Uri.parse(
      '${Constants.baseApiURL}/products');
  final List<Product> _items = [];

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

  ///Carrega os produtos que estão no banco de dados
  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    Map<String, dynamic> data = json.decode(response.body);
    _items.clear();
    if (data != null) {
      data.forEach(
        (productId, productData) => _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        ),
      );
      notifyListeners();
    }
    return Future.value();
  }

  ///Função para adicionar um produto
  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    );
    var id = json.decode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        title: newProduct.title,
        price: newProduct.price,
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
      ),
    );
    notifyListeners();
  }

  ///Atualiza um produto
  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) return;
    final index =
        _items.indexWhere((productItem) => productItem.id == product.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse('$_baseUrl/${product.id}.json'),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  ///Remove um produto
  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();
      final response =
          await http.delete(Uri.parse('$_baseUrl/${product.id}.json'));
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto');
      }
    }
  }
}
