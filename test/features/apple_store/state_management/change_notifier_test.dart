import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/state_management/change_notifier/cart_change_notifier.dart';

void main() {
  group('CartChangeNotifier Tests', () {
    late CartChangeNotifier notifier;
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    setUp(() {
      notifier = CartChangeNotifier();
    });

    test('Initial state is empty', () {
      expect(notifier.state.items.isEmpty, true);
      expect(notifier.state.itemCount, 0);
    });

    test('Add item to cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);

      expect(notifier.state.items.length, 1);
      expect(notifier.state.itemCount, 1);
      expect(notifier.state.items[0].product.id, product.id);
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

      expect(notifier.state.items.length, 1);
      expect(notifier.state.itemCount, 2);
      expect(notifier.state.items[0].quantity, 2);
    });

    test('Remove item from cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);
      expect(notifier.state.items.length, 1);

      notifier.removeItem(notifier.state.items[0]);
      expect(notifier.state.items.isEmpty, true);
    });

    test('Update quantity', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);
      notifier.updateQuantity(notifier.state.items[0], 5);

      expect(notifier.state.items[0].quantity, 5);
      expect(notifier.state.itemCount, 5);
    });

    test('Clear cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      notifier.addToCart(item);
      notifier.clearCart();

      expect(notifier.state.items.isEmpty, true);
    });
  });
}
