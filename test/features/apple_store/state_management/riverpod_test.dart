import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/state_management/riverpod/cart_provider.dart';

void main() {
  group('Riverpod CartProvider Tests', () {
    late ProviderContainer container;
    final product = dummyProducts[0];
    final color = product.availableColors[0];
    final storage = product.storageOptions[0];

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state is empty', () {
      final state = container.read(cartProvider);
      expect(state.items.isEmpty, true);
    });

    test('Add item to cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      container.read(cartProvider.notifier).addToCart(item);

      final state = container.read(cartProvider);
      expect(state.items.length, 1);
      expect(state.itemCount, 1);
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

      container.read(cartProvider.notifier).addToCart(item1);
      container.read(cartProvider.notifier).addToCart(item2);

      final state = container.read(cartProvider);
      expect(state.items.length, 1);
      expect(state.itemCount, 2);
    });
    
    test('Remove item', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      container.read(cartProvider.notifier).addToCart(item);
      final addedItem = container.read(cartProvider).items[0];
      
      container.read(cartProvider.notifier).removeItem(addedItem);
      
      expect(container.read(cartProvider).items.isEmpty, true);
    });

    test('Clear cart', () {
      final item = CartItem(
        id: '1',
        product: product,
        selectedColor: color,
        selectedStorage: storage,
      );

      container.read(cartProvider.notifier).addToCart(item);
      container.read(cartProvider.notifier).clearCart();
      
      expect(container.read(cartProvider).items.isEmpty, true);
    });
  });
}
