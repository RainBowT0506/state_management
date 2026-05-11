import 'package:get/get.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

class CartGetController extends GetxController {
  // 使用 .obs 建立響應式狀態
  final _state = CartState().obs;
  
  CartState get state => _state.value;

  void addToCart(CartItem item) {
    final existingIndex = _state.value.items.indexWhere((i) => 
      i.product.id == item.product.id && 
      i.selectedColor.name == item.selectedColor.name && 
      i.selectedStorage.size == item.selectedStorage.size &&
      i.hasAppleCare == item.hasAppleCare
    );

    if (existingIndex >= 0) {
      final List<CartItem> newItems = List.from(_state.value.items);
      newItems[existingIndex] = newItems[existingIndex].copyWith(
        quantity: newItems[existingIndex].quantity + 1,
      );
      _state.value = _state.value.copyWith(items: newItems);
    } else {
      _state.value = _state.value.copyWith(items: [..._state.value.items, item]);
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    final List<CartItem> newItems = _state.value.items.map((i) {
      if (i.id == item.id) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();
    _state.value = _state.value.copyWith(items: newItems);
  }

  void removeItem(CartItem item) {
    final newItems = _state.value.items.where((i) => i.id != item.id).toList();
    _state.value = _state.value.copyWith(items: newItems);
  }

  void clearCart() {
    _state.value = CartState();
  }
}
