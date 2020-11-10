import 'package:flutter/material.dart';
import '../models/product.dart';

///Tela de detalhes de um produto
class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Produto que vai ser detalhado
    var product = ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
