import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../utils/app_routes.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';

///Representa a tela que lista todos os produtos
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<Products>();
    final productsItems = products.items;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.productForm),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (context, [index]) => Column(
              children: [
                ProductItem(productsItems[index]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProducts(BuildContext context) =>
      context.read<Products>().loadProducts();
}
