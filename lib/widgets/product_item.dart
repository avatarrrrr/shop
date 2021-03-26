import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../utils/app_routes.dart';

///Componente que representa um produto da tela 'Gerenciar Produtos'
class ProductItem extends StatelessWidget {
  ///Produto
  final Product product;

  ///O produto é passado através do construtor
  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.productForm,
                arguments: product,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Tem certeza?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<Products>().deleteProduct(product.id);
                        Navigator.of(context).pop();
                      },
                      child: Text('Sim'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Não'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
