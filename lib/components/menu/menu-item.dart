import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/providers/main-page-provider.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    required this.text,
    required this.pageState,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String text;
  final MainPageState pageState;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      leading: Icon(icon, color: Colors.white),
      onTap: () {
        context.read<MainPageProvider>().state = pageState;
      },
    );
  }
}
