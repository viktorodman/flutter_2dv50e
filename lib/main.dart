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
        return MaterialApp(
          initialRoute: RouteManager.login,
          onGenerateRoute: RouteManager.generateRoute,
          theme: ThemeData(
            primaryColor: Color.fromRGBO(96, 125, 139, 1),
            textTheme: TextTheme(
                headline4: TextStyle(
              color: Color.fromRGBO(96, 125, 139, 1),
            )),
            /* cardColor: const Color.fromRGBO(96, 125, 139, 1), */
            scaffoldBackgroundColor: Colors.white,
            drawerTheme: DrawerThemeData(
              backgroundColor: const Color.fromRGBO(96, 125, 139, 1),
              elevation: 1.0,
            ),
          ),
        );
      },
    );
  }
}
