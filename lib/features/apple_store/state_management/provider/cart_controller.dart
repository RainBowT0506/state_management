import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

/// Provider 架構下的控制器
/// 負責維護 CartState 並提供操作方法
class CartController extends ChangeNotifier {
  CartState _state = CartState();

  CartState get state => _state;

  // 使用者可以透過 context.select((CartController c) => c.itemCount) 來優化效能
  int get itemCount => _state.itemCount;

  void addToCart(CartItem item) {
    final existingIndex = _state.items.indexWhere((i) => 
      i.product.id == item.product.id && 
      i.selectedColor.name == item.selectedColor.name && 
      i.selectedStorage.size == item.selectedStorage.size &&
      i.hasAppleCare == item.hasAppleCare
    );

    if (existingIndex >= 0) {
      final List<CartItem> newItems = List.from(_state.items);
      newItems[existingIndex] = newItems[existingIndex].copyWith(
        quantity: newItems[existingIndex].quantity + 1,
      );
      _state = _state.copyWith(items: newItems);
    } else {
      _state = _state.copyWith(items: [..._state.items, item]);
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    final List<CartItem> newItems = _state.items.map((i) {
      if (i.id == item.id) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();
    _state = _state.copyWith(items: newItems);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    final newItems = _state.items.where((i) => i.id != item.id).toList();
    _state = _state.copyWith(items: newItems);
    notifyListeners();
  }

  void clearCart() {
    _state = CartState();
    notifyListeners();
  }
}
