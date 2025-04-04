import 'package:uuid/uuid.dart';

class Item {
  final String id;
  final String name;
  final int price;
  final String description;
  final String image_path;

  Item({
    String? id,
    required this.name,
    required this.price,
    required this.description,
    required this.image_path,
  }) : id = id ?? const Uuid().v4();

  Item copyWith({
    String? name,
    int? price,
    String? description,
    String? image_path,
  }) {
    return Item(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image_path: image_path ?? this.image_path,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
