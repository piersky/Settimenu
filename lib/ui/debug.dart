import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugUI extends StatefulWidget {
  static const String id = 'debug_ui';

  const DebugUI({super.key});

  @override
  _DebugUIState createState() => _DebugUIState();
}

class _DebugUIState extends State<DebugUI> {
  SharedPreferences? _prefs;
  Set<String> keys = {};

  @override
  void initState() {
    super.initState();
    printAllSharedPreferences();
  }

  void printAllSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      keys = _prefs!.getKeys();
    });

    for (String key in keys) {
      final value = _prefs?.get(key);
      print('$key: $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Shared Preferences',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                if (keys.isEmpty) {
                  return const Center(child: Text('No items available'));
                } else {
                  String key = keys.elementAt(index);
                  final value = _prefs?.get(key);

                  String displayValue;
                  if (value is String) {
                    displayValue = value;
                  } else if (value is bool) {
                    displayValue = value ? 'true' : 'false';
                  } else if (value is int) {
                    displayValue = value.toString();
                  } else if (value is double) {
                    displayValue = value.toString();
                  } else {
                    displayValue = 'Unknown type';
                  }

                  return ListTile(
                    dense: true,
                    title: Text(key),
                    subtitle: Text(displayValue),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
