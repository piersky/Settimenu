import 'package:flutter/material.dart';
import 'helper.dart';

class DatabaseDataUI extends StatelessWidget {
  static const String id = 'database_data_ui';

  const DatabaseDataUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Data')),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: DatabaseHelper.instance.queryAllTablesData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          } else {
            final allData = snapshot.data!;
            return ListView(
              children: allData.entries.map((entry) {
                final tableName = entry.key;
                final tableData = entry.value;
                return ExpansionTile(
                  title: Text(
                    tableName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: tableData.map((row) {
                    return ListTile(
                      title: Text(row['name']?.toString() ?? 'No name'),
                      subtitle: Text(
                        row.entries
                            .where((e) => e.key != 'name')
                            .map((e) => '${e.key}: ${e.value}')
                            .join(', '),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
