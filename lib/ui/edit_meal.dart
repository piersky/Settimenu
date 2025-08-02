import 'package:flutter/material.dart';

class EditMealUI extends StatefulWidget {
  static const String id = 'edit_meal_ui';
  final int daySelected;
  final String mealType;

  const EditMealUI({
    super.key,
    required this.daySelected,
    required this.mealType,
  });

  @override
  _EditMealUIState createState() => _EditMealUIState();
}

class _EditMealUIState extends State<EditMealUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.mealType} for Day ${widget.daySelected}'),
      ),
      body: Center(
        child: Text('Editing ${widget.mealType} for Day ${widget.daySelected}'),
      ),
    );
  }
}
