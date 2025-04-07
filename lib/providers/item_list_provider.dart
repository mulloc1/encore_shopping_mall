import 'package:encore_shopping_mall/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemListNotifier extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateItem(Item updatedItem) {
    state = state.map((item) => 
      item.id == updatedItem.id ? updatedItem : item
    ).toList();
  }

  void clearItems() {
    state = [];
  }
}

final itemListProvider = NotifierProvider<ItemListNotifier, List<Item>>(() {
  return ItemListNotifier();
});
