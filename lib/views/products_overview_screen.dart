import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

///Widget Main
class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Lista com todos produtos
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: ProductGrid(),
    );
  }
}
