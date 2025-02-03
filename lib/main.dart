import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zema/app_widget.dart';
import 'package:zema/config/routes/routes.dart';
import 'package:zema/core/service/firebase.dart';
import 'package:zema/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "Zema");
  await initializeDependencies();

  final firebaseService = AuthService();
  firebaseService.authStateChanges.listen((User? user) {
    router.refresh();
  });
  runApp(const AppWidget());
}
