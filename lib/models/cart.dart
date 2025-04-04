import 'package:encore_shopping_mall/models/selected_item.dart';

class Cart {
  final List<SelectedItem> cart_list = [];
  final int total_item_count = 0;

  Cart();

  Cart copyWith({List<SelectedItem>? cart_list}) {
    return Cart();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cart &&
        other.cart_list.length == cart_list.length &&
        other.cart_list.every((item) => cart_list.contains(item));
  }

  @override
  int get hashCode => Object.hashAll(cart_list);
}
