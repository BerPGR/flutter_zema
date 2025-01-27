import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zema/core/service/firebase.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final firebaseService = AuthService();
  bool isRegistering = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).dialogBackgroundColor,
            Theme.of(context).primaryColor
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SafeArea(
                child: Text(
              "Welcome to Zema!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            Form(
              key: _formKey,
              child: Column(
                spacing: 24,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(label: Text("E-Mail")),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required.";
                      }

                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      final matchRegex = emailRegex.hasMatch(value);
                      if (!matchRegex) {
                        return "Email is invalid.";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(label: Text("Password")),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password is required.";
                      }

                      if (value.trim().length < 8) {
                        return "Password must be higher than 8 characters";
                      }
                      return null;
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 100, child: Divider(color: Colors.white)),
                      Text("Or"),
                      SizedBox(width: 100, child: Divider(color: Colors.white)),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isRegistering = !isRegistering;
                        });
                      },
                      child: Text(!isRegistering
                          ? "Register account"
                          : "Login account"))
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      if (_formKey.currentState!.validate() && isRegistering) {
                        firebaseService.registerWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        context.go("/onboarding");
                      } else if (_formKey.currentState!.validate() &&
                          !isRegistering) {
                        firebaseService.signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        context.go("/");
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("$e")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(!isRegistering ? "Login" : "Register"),
                ))
          ],
        ),
      ),
    );
  }
}
