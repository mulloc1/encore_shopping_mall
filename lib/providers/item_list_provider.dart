import 'package:encore_shopping_mall/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemListProvider = StateProvider<List<Item>>((ref) {
  return [];
});
