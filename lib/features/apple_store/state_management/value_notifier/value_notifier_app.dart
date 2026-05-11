import 'package:flutter/material.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'cart_value_notifier.dart';

class ValueNotifierApp extends StatefulWidget {
  const ValueNotifierApp({super.key});

  @override
  State<ValueNotifierApp> createState() => _ValueNotifierAppState();
}

class _ValueNotifierAppState extends State<ValueNotifierApp> {
  final CartValueNotifier _notifier = CartValueNotifier();

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            // 使用 ValueListenableBuilder 監聽 ValueNotifier 的變化
            return ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (context, state, child) {
                return buildAppleStoreFlow(
                  context: context,
                  title: 'ValueNotifier',
                  state: state,
                  onAddToCart: _notifier.addToCart,
                  onUpdateQuantity: _notifier.updateQuantity,
                  onRemoveItem: _notifier.removeItem,
                  onClearCart: _notifier.clearCart,
                );
              },
            );
          },
        );
      },
    );
  }
}
