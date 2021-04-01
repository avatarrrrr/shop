import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item_widget.dart';

///Tela que mostra os produtos no carrinho
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    var cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, index) {
                return CartItemWidget(cartItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

///Botão de Comprar da tela de carrinho
class OrderButton extends StatefulWidget {
  ///Recebe o carrinho como parametro;
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  ///Carrinho com os itens do pedido
  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            )
          : Text('COMPRAR'),
      onPressed: widget.cart.totalAmount == 0
          ? null
          : () async {
              setState(() => isLoading = true);
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cart);
              setState(() => isLoading = false);
              widget.cart.clear();
            },
    );
  }
}
