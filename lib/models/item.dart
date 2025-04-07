import 'dart:io';

import 'package:uuid/uuid.dart';

class Item {
  final String id;
  final String name;
  final int price;
  final String description;
  final File image;
  int quantity = 0;

  Item({
    String? id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.quantity = 0,
  }) : id = const Uuid().v4();

  Item copyWith({
    String? name,
    int? price,
    String? description,
    File? image,
    int? quantity,
  }) {
    return Item(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
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
