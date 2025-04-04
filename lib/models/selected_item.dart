import 'package:encore_shopping_mall/models/item.dart';

class SelectedItem {
  final Item item;
  final int item_count;

  SelectedItem({required this.item, required this.item_count});

  SelectedItem copyWith({Item? item, int? item_count}) {
    return SelectedItem(
      item: item ?? this.item,
      item_count: item_count ?? this.item_count,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedItem &&
        other.item == item &&
        other.item_count == item_count;
  }

  @override
  int get hashCode => Object.hash(item, item_count);
}
