import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

///Tela de pedidos
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    context
        .read<Orders>()
        .loadOrders()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => context.read<Orders>().loadOrders(),
              child: ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, index) => OrderWidget(orders.items[index]),
              ),
            ),
    );
  }
}
