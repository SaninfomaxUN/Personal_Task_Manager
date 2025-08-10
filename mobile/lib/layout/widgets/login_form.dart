import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../controller/auth_controller.dart';
import '../../data/entites/user_entity.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginForm({super.key, required this.onLoginSuccess});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false; // Para mostrar un indicador de carga

  Future<void> _login() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    if (kDebugMode) {
      print('Intentando iniciar sesión con: $_usernameController.text');
      print('Contraseña: $_passwordController.text');
    }

    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      final response = await loginApi(UserEntity(
        username: username,
        password: password,
      ));


      if (response.accessToken.isNotEmpty) {
        await Config.saveAccessToken(response.accessToken);
        await Config.saveUsername(username);
        widget.onLoginSuccess();
      } else {
        setState(() {
          _errorMessage = 'Usuario o contraseña incorrectos.';
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Bienvenido',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Usuario',
              hintText: 'Tu usuario',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa tu usuario';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa tu contraseña';
              }
              if (value.length < 4) {
                return 'La contraseña debe tener al menos 4 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 12.0),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 12.0),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Iniciar Sesión'),
          ),
          // Puedes añadir más widgets aquí como "Olvidé mi contraseña" o "Registrarse"
          // TextButton(
          //   onPressed: () {
          //     // Lógica para "Olvidé mi contraseña"
          //   },
          //   child: const Text('¿Olvidaste tu contraseña?'),
          // ),
        ],
      ),
    );
  }
}