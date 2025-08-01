import 'package:flutter/material.dart';

class MenusUI extends StatefulWidget {
  static const String id = 'menus_ui';

  const MenusUI({super.key});

  @override
  _MenusUIState createState() => _MenusUIState();
}

class _MenusUIState extends State<MenusUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menus')),
      body: Center(
        child: Text(
          'This is the Menus UI',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
