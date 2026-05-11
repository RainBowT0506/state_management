import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/state_management/bloc/cart_cubit.dart';

void main() {
  group('CartCubit Tests', () {
    late CartCubit cubit;
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    setUp(() {
      cubit = CartCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('Initial state is empty', () {
      expect(cubit.state.items.isEmpty, true);
    });

    test('Add item emits new state', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      cubit.addToCart(item);

      expect(cubit.state.items.length, 1);
      expect(cubit.state.itemCount, 1);
    });

    test('Add same item increments quantity', () {
      final item1 = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      final item2 = CartItem(
        id: '2',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      cubit.addToCart(item1);
      cubit.addToCart(item2);

      expect(cubit.state.items.length, 1);
      expect(cubit.state.items[0].quantity, 2);
    });

    test('Remove item', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      cubit.addToCart(item);
      cubit.removeItem(cubit.state.items[0]);

      expect(cubit.state.items.isEmpty, true);
    });
  });
}
