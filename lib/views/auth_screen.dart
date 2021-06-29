import 'package:flutter/material.dart';

///Tela de autenticação, o aplicativo sempre irá se inicializar com ele.
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 177, 255, 0.5),
                  Color.fromRGBO(255, 188, 177, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
