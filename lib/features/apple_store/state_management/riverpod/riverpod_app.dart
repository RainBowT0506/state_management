import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'cart_provider.dart';

class RiverpodApp extends StatelessWidget {
  const RiverpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Riverpod 需要在頂層包裹 ProviderScope
    return ProviderScope(
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              // 使用 Consumer 來讀取 Riverpod 的狀態
              return Consumer(
                builder: (context, ref, child) {
                  // 監聽狀態變化
                  final cartState = ref.watch(cartProvider);
                  // 取得 Notifier 實例來呼叫方法
                  final notifier = ref.read(cartProvider.notifier);

                  return buildAppleStoreFlow(
                    context: context,
                    title: 'Riverpod',
                    state: cartState,
                    onAddToCart: notifier.addToCart,
                    onUpdateQuantity: notifier.updateQuantity,
                    onRemoveItem: notifier.removeItem,
                    onClearCart: notifier.clearCart,
                    cartPageBuilder: (context) => Consumer(
                      builder: (context, ref, child) {
                        final currentState = ref.watch(cartProvider);
                        return buildCommonCartPage(
                          context: context,
                          state: currentState,
                          onUpdateQuantity: notifier.updateQuantity,
                          onRemoveItem: notifier.removeItem,
                          onClearCart: notifier.clearCart,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
