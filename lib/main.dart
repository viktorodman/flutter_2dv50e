import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/user.dart';
import 'package:flutter_2dv50e/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => User()),
        ),
      ],
      builder: (context, child) {
        return const MaterialApp(
          initialRoute: RouteManager.login,
          onGenerateRoute: RouteManager.generateRoute,
        );
      },
    );
  }
}
