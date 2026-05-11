import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

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
      emit(state.copyWith(items: newItems));
    } else {
      emit(state.copyWith(items: [...state.items, item]));
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    final List<CartItem> newItems = state.items.map((i) {
      if (i.id == item.id) {
        return i.copyWith(quantity: quantity);
      }
      return i;
    }).toList();
    emit(state.copyWith(items: newItems));
  }

  void removeItem(CartItem item) {
    final newItems = state.items.where((i) => i.id != item.id).toList();
    emit(state.copyWith(items: newItems));
  }

  void clearCart() {
    emit(CartState());
  }
}
