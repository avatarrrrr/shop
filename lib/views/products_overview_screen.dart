import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';

///Widget Main
class ProductOverviewScreen extends StatelessWidget {
  ///Lista com todos produtos
  final List<Product> loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) => Text(loadedProducts[index].title),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
