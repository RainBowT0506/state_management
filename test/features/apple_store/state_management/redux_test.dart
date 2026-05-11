import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/features/apple_store/state_management/redux/cart_redux.dart';

void main() {
  group('Redux Reducer Tests', () {
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    test('AddToCartAction adds item', () {
      final initialState = CartState();
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      final newState = cartReducer(initialState, AddToCartAction(item));

      expect(newState.items.length, 1);
      expect(newState.itemCount, 1);
    });

    test('AddToCartAction increments quantity for existing item', () {
      final item1 = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      final state1 = cartReducer(CartState(), AddToCartAction(item1));
      
      final item2 = CartItem(
        id: '2',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );
      
      final state2 = cartReducer(state1, AddToCartAction(item2));

      expect(state2.items.length, 1);
      expect(state2.items[0].quantity, 2);
    });

    test('UpdateQuantityAction works', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      final state1 = cartReducer(CartState(), AddToCartAction(item));
      final state2 = cartReducer(state1, UpdateQuantityAction(state1.items[0], 10));

      expect(state2.items[0].quantity, 10);
    });

    test('RemoveItemAction works', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      final state1 = cartReducer(CartState(), AddToCartAction(item));
      final state2 = cartReducer(state1, RemoveItemAction(state1.items[0]));

      expect(state2.items.isEmpty, true);
    });
  });
}
