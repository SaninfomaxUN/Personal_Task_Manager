import 'package:flutter/material.dart';
import 'config/config.dart';
import 'routes/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await Config.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      initialRoute: '/login',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}


