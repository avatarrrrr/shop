import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../providers/orders.dart';

///Item da lista de pedidos
class OrderWidget extends StatelessWidget {
  ///Pedido que será representado
  final Order order;

  ///Obtém um pedido
  OrderWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text('R\$ ${order.total}'),
        subtitle: Text(
          DateFormat('dd/MM/yyyy hh:mm').format(order.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
