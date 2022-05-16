import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/app_routes.dart';

///Drawer que possibilita a navegação entre a tela inicial e a tela de pedidos
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.orders),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.products),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              context.read<Auth>().logout();
              Navigator.pushReplacementNamed(context, AppRoutes.auth);
            },
          ),
        ],
      ),
    );
  }
}
