import 'package:flutter/material.dart';

///Teste do InheritedWidget
class CounterState {
  int _value = 1;

  ///Aumenta o valor em + 1
  void inc() => _value++;

  ///Diminui o valor em - 1
  void dec() => _value--;

  ///Obtem o valor
  int get value => _value;

  ///Verifica se duas instâncias são a mesma
  bool diff(CounterState old) => old == null || old._value != _value;
}

///Classe para testar o InheritedWidget
class CounterProvider extends InheritedWidget {
  ///Estado da classe (é definido acima)
  final CounterState state = CounterState();

  ///Definindo um construtor que recebe a propriedade child:
  CounterProvider({Widget child}) : super(child: child);

  ///N lembro mais o que isso retorna kkkk
  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
