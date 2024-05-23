import 'package:asp/asp.dart';
import 'package:coin_app/app/app.dart';
import 'package:coin_app/app/injector.dart';
import 'package:flutter/material.dart';

void main() {
  // Setup project
  initializeConfigurations();
  registerInstances();

  runApp(const RxRoot(child: MyApp()));
}
