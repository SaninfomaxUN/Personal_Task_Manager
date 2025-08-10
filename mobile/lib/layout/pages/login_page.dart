import 'package:flutter/material.dart';
import '../widgets/login_form.dart'; // Asumiremos que el formulario está aquí


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Personal Task Manager'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView( // Para evitar overflow si el teclado aparece
          padding: const EdgeInsets.all(16.0),
          child: LoginForm(
            onLoginSuccess: () {
              _navigateToHome(context);
            },
          ),
        ),
      ),
    );
  }
}
