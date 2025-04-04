import 'package:encore_shopping_mall/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemListNotifier extends StateNotifier<List<Item>> {
  ItemListNotifier() : super([]);

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

final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>((ref) {
  return ItemListNotifier();
});
