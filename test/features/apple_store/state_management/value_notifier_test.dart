import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/state_management/value_notifier/cart_value_notifier.dart';

void main() {
  group('CartValueNotifier Tests', () {
    late CartValueNotifier notifier;
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    setUp(() {
      notifier = CartValueNotifier();
    });

    test('Initial state is empty', () {
      expect(notifier.value.items.isEmpty, true);
    });

    test('Add item to cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);

      expect(notifier.value.items.length, 1);
      expect(notifier.value.itemCount, 1);
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

      notifier.addToCart(item1);
      notifier.addToCart(item2);

      expect(notifier.value.items.length, 1);
      expect(notifier.value.items[0].quantity, 2);
    });

    test('Remove item', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);
      notifier.removeItem(notifier.value.items[0]);

      expect(notifier.value.items.isEmpty, true);
    });
  });
}
