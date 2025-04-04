import 'package:encore_shopping_mall/models/item.dart';

class ItemList {
  final List<Item> itemList = [];
  final int total_item_count = 0;

  ItemList();

  ItemList copyWith({List<Item>? itemList}) {
    return ItemList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemList &&
        other.itemList.length == itemList.length &&
        other.itemList.every((item) => itemList.contains(item));
  }

  @override
  int get hashCode => Object.hashAll(itemList);
}
