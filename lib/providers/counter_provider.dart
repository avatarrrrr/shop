import 'package:flutter/material.dart';

class CounterState {
  int _value = 1;
  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) => old == null || old._value != _value;
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({Widget child}) : super(child: child);

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
