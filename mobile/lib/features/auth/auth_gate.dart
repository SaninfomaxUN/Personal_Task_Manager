import 'package:flutter/material.dart';
import 'package:mobile/features/auth/verify_token.dart';
import '../../layout/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  final Widget authenticatedPage;
  const AuthGate({super.key, required this.authenticatedPage});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkExpirationTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return authenticatedPage;
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
