import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

///Tela de pedidos
class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: context.read<Orders>().loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<Orders>(
              builder: (context, orders, child) => RefreshIndicator(
                onRefresh: () => context.read<Orders>().loadOrders(),
                child: ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
