import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'store/provider_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void loginHandler() {
    final username = usernameTextController.text;
    final password = passwordTextController.text;

    final providerAuth = context.read<ProviderAuth>();

    providerAuth
        .login(username: username, password: password)
        .then((_) {
          usernameTextController.clear();
          passwordTextController.clear();
          Navigator.of(context).pushReplacementNamed('/product-list');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('LOGIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameTextController,
                decoration: const InputDecoration(label: Text('Username')),
              ),
              TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: loginHandler,
                child: const Text('LOGIN'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
