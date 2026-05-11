import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

// 定義一個 NotifierProvider
final cartProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});

class CartNotifier extends Notifier<CartState> {
  // 初始化狀態
  @override
  CartState build() {
    return CartState();
  }

  void addToCart(CartItem item) {
    final existingIndex = state.items.indexWhere((i) => 
      i.product.id == item.product.id && 
      i.selectedColor.name == item.selectedColor.name && 
      i.selectedStorage.size == item.selectedStorage.size &&
      i.hasAppleCare == item.hasAppleCare
    );

    if (existingIndex >= 0) {
      final List<CartItem> newItems = List.from(state.items);
      newItems[existingIndex] = newItems[existingIndex].copyWith(
        quantity: newItems[existingIndex].quantity + 1,
      );
      state = state.copyWith(items: newItems);
    } else {
      state = state.copyWith(items: [...state.items, item]);
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    final List<CartItem> newItems = state.items.map((i) {
      if (i.id == item.id) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();
    state = state.copyWith(items: newItems);
  }

  void removeItem(CartItem item) {
    final newItems = state.items.where((i) => i.id != item.id).toList();
    state = state.copyWith(items: newItems);
  }

  void clearCart() {
    state = CartState();
  }
}
