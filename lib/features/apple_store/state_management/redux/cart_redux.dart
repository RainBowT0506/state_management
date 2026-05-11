import 'package:redux/redux.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

// Actions
class AddToCartAction {
  final CartItem item;
  AddToCartAction(this.item);
}

class UpdateQuantityAction {
  final CartItem item;
  final int quantity;
  UpdateQuantityAction(this.item, this.quantity);
}

class RemoveItemAction {
  final CartItem item;
  RemoveItemAction(this.item);
}

class ClearCartAction {}

// Reducer
CartState cartReducer(CartState state, dynamic action) {
  if (action is AddToCartAction) {
    final item = action.item;
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
      return state.copyWith(items: newItems);
    } else {
      return state.copyWith(items: [...state.items, item]);
    }
  }

  if (action is UpdateQuantityAction) {
    final newItems = state.items.map((i) {
      if (i.id == action.item.id) {
        return i.copyWith(quantity: action.quantity);
      }
      return i;
    }).toList();
    return state.copyWith(items: newItems);
  }

  if (action is RemoveItemAction) {
    final newItems = state.items.where((i) => i.id != action.item.id).toList();
    return state.copyWith(items: newItems);
  }

  if (action is ClearCartAction) {
    return CartState();
  }

  return state;
}
