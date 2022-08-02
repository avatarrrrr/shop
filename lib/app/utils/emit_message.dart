import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void throwMessageToUser({required String message}) {
  final context = GetIt.instance<GlobalKey<NavigatorState>>().currentContext!;

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
