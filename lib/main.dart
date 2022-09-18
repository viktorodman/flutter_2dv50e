import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String _initialRoute = RouteManager.dashboard;

void main() async {
  /* bool isLoggedIn = await AuthService.isAuthenticated();

  if (isLoggedIn) {
    _initialRoute = RouteManager.dashboard;
  } */
  await dotenv.load(fileName: "env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Future signInUser() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _initialRoute,
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
  }
}
