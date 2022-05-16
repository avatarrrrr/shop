import 'package:flutter/material.dart';

///Implementa a bolinha com a quantidade de itens no carrinho
class Badge extends StatelessWidget {
  ///Widget onde vamos colocar a bolinha
  final Widget? child;

  ///Número que vai estar na bolinha
  final String value;

  ///Cor da bolinha
  final String? color;

  ///Construtor que pega os valores acima
  Badge({
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child!,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color != null ? color as Color? : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
