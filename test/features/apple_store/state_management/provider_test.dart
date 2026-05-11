import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/state_management/provider/cart_controller.dart';

void main() {
  group('CartController (Provider) Tests', () {
    late CartController controller;
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    setUp(() {
      controller = CartController();
    });

    test('Initial state is empty', () {
      expect(controller.state.items.isEmpty, true);
    });

    test('Add item to cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      controller.addToCart(item);

      expect(controller.state.items.length, 1);
      expect(controller.state.itemCount, 1);
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

      controller.addToCart(item1);
      controller.addToCart(item2);

      expect(controller.state.items.length, 1);
      expect(controller.state.items[0].quantity, 2);
    });

    test('Remove item', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      controller.addToCart(item);
      controller.removeItem(controller.state.items[0]);

      expect(controller.state.items.isEmpty, true);
    });
  });
}
