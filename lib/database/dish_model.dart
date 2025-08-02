import 'package:settimenu/utils/costants.dart';

class DishModel {
  final int? id;
  final String menuId;
  final String name;
  final String description;
  final double imagePath;
  final String mealType;
  final String weekday;
  final int isActive;

  DishModel({
    this.id,
    required this.menuId,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.mealType,
    required this.weekday,
    this.isActive = 1,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json[kDishesTableId] as int,
      menuId: json[kDishesTableMenuId] as String,
      name: json[kDishesTableName] as String,
      description: json[kDishesTableDescription] as String,
      imagePath: json[kDishesTableImagePath] as double,
      mealType: json[kDishesTableMealType] as String,
      weekday: json[kDishesTableWeekday] as String,
      isActive: json[kDishesTableIsActive] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kDishesTableId: id,
      kDishesTableMenuId: menuId,
      kDishesTableName: name,
      kDishesTableDescription: description,
      kDishesTableImagePath: imagePath,
      kDishesTableMealType: mealType,
      kDishesTableWeekday: weekday,
      kDishesTableIsActive: isActive,
    };
  }
}
