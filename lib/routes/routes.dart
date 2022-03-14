import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/pages/dashboard.dart';
import 'package:flutter_2dv50e/pages/login.dart';

class RouteManager {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String publicDisplay = '/display';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (context) => const Dashboard(),
        );

      case publicDisplay:
        return MaterialPageRoute(
          builder: (context) => const Text('publicDisplay'),
        );
      default:
        throw const FormatException('Route not found');
    }
  }
}
