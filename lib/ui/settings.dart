import 'package:flutter/material.dart';

class SettingsUI extends StatelessWidget {
  static const String id = 'settings_ui';

  const SettingsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
