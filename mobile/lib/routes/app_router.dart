import 'package:flutter/material.dart';
import '../features/auth/auth_gate.dart';
import '../layout/pages/home_page.dart';
import '../layout/pages/login_page.dart';
import '../layout/pages/updateTask_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/':
        return MaterialPageRoute(
          builder: (context) => AuthGate(
            authenticatedPage: const HomePage(),
          ),
        );
      case '/updateTask':
        final taskId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => AuthGate(
              authenticatedPage: UpdateTaskPage(
                taskId: taskId,
              )),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => AuthGate(
            authenticatedPage: const HomePage(),
          ),
        );
    }
  }
}

