import 'package:flutter/material.dart';
import 'package:zema/app_widget.dart';
import 'package:zema/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const AppWidget());
}