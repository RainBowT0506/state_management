import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

// 使用 ChangeNotifier 管理購物車邏輯
class CartChangeNotifier extends ChangeNotifier {
  // 私有狀態
  CartState _state = CartState();

  // 對外公開的唯讀狀態
  CartState get state => _state;

  // 新增商品並通知監聽者
  void addToCart(CartItem item) {
    final existingIndex = _state.items.indexWhere((i) => 
      i.product.id == item.product.id && 
      i.selectedColor.name == item.selectedColor.name && 
      i.selectedStorage.size == item.selectedStorage.size &&
      i.hasAppleCare == item.hasAppleCare
    );

    if (existingIndex >= 0) {
      final List<CartItem> newItems = List.from(_state.items);
      newItems[existingIndex].quantity += 1;
      _state = _state.copyWith(items: newItems);
    } else {
      _state = _state.copyWith(items: [..._state.items, item]);
    }
    // 重要：通知所有正在監聽此 Notifier 的 Widget 進行刷新
    notifyListeners();
  }

  // 更新數量並通知刷新
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

  // 移除項目並通知刷新
  void removeItem(CartItem item) {
    final newItems = _state.items.where((i) => i.id != item.id).toList();
    _state = _state.copyWith(items: newItems);
    notifyListeners();
  }

  // 清空購物車並通知刷新
  void clearCart() {
    _state = CartState();
    notifyListeners();
  }
}
