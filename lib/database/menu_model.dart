import '../utils/costants.dart';

class MenuModel {
  final int? id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int isActive;

  MenuModel({
    this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.isActive = 1,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json[kMenusTableId] as int,
      name: json[kMenusTableName] as String,
      description: json[kMenusTableDescription] as String?,
      imageUrl: json[kMenusTableImageUrl] as String?,
      isActive: json[kMenusTableIsActive] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kMenusTableId: id,
      kMenusTableName: name,
      kMenusTableDescription: description,
      kMenusTableImageUrl: imageUrl,
      kMenusTableIsActive: isActive,
    };
  }
}
