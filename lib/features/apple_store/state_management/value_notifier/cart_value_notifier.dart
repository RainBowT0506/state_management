import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

// 使用 ValueNotifier 管理狀態，它直接持有一個值 (value)
class CartValueNotifier extends ValueNotifier<CartState> {
  // 初始化時傳入初始狀態
  CartValueNotifier() : super(CartState());

  void addToCart(CartItem item) {
    final existingIndex = value.items.indexWhere((i) => 
      i.product.id == item.product.id && 
      i.selectedColor.name == item.selectedColor.name && 
      i.selectedStorage.size == item.selectedStorage.size &&
      i.hasAppleCare == item.hasAppleCare
    );

    if (existingIndex >= 0) {
      final List<CartItem> newItems = List.from(value.items);
      newItems[existingIndex].quantity += 1;
      // 直接修改 value 就會自動觸發監聽者刷新
      value = value.copyWith(items: newItems);
    } else {
      value = value.copyWith(items: [...value.items, item]);
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    final List<CartItem> newItems = value.items.map((i) {
      if (i.id == item.id) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();
    value = value.copyWith(items: newItems);
  }

  void removeItem(CartItem item) {
    final newItems = value.items.where((i) => i.id != item.id).toList();
    value = value.copyWith(items: newItems);
  }

  void clearCart() {
    value = CartState();
  }
}
