import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settimenu/database/database_data.dart';

import '../utils/costants.dart';
import 'debug.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DEBUG
            if (kAppDebugMode) ...[
              _buildSectionTitle('DEBUG'),
              _buildSettingItem(
                context,
                icon: const Icon(
                  FontAwesomeIcons.usb,
                  size: 20.0,
                  color: Colors.green,
                ),
                title: "Shared preferences",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DebugUI()),
                  );
                },
              ),
              _buildSettingItem(
                context,
                icon: Icon(
                  FontAwesomeIcons.database,
                  size: 20,
                  color: Colors.deepPurple,
                ),
                title: "Database",
                onTap: () {
                  Navigator.pushNamed(context, DatabaseDataUI.id);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 20.0,
      right: 20.0,
      bottom: 5.0,
      left: 20.0,
    ),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
      ),
    ),
  );
}

Widget _buildSettingItem(
  BuildContext context, {
  required Icon icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Card(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 0.0,
    child: ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 16.0)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
      dense: true,
    ),
  );
}
