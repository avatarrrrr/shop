import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'product_grid_item.dart';

///Grid de que lista os produtos
class ProductGrid extends StatelessWidget {
  ///Decide se mostra só os favoritos ou não
  final bool? showFavoriteOnly;

  ///Construtor que recebe o bool se mostra só favorito ou não
  const ProductGrid({this.showFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    var products = showFavoriteOnly!
        ? Provider.of<Products>(context).favoriteItems
        : Provider.of<Products>(context).items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
