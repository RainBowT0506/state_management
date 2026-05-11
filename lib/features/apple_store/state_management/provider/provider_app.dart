import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'cart_controller.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 ChangeNotifierProvider 提供控制器
    return ChangeNotifierProvider(
      create: (_) => CartController(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              // 使用 context.watch<T>() 來監聽狀態變化
              // 這與 Consumer 效果相同，但語法更接近原生 Dart
              final controller = context.watch<CartController>();
              
              return buildAppleStoreFlow(
                context: context,
                title: 'Provider',
                state: controller.state,
                // 使用 context.read<T>() 來執行不觸發重繪的動作
                onAddToCart: controller.addToCart,
                onUpdateQuantity: controller.updateQuantity,
                onRemoveItem: controller.removeItem,
                onClearCart: controller.clearCart,
                cartPageBuilder: (context) {
                  // 在這裡使用 Consumer 或 watch 來確保 CartPage 是響應式的
                  final currentController = context.watch<CartController>();
                  return buildCommonCartPage(
                    context: context,
                    state: currentController.state,
                    onUpdateQuantity: currentController.updateQuantity,
                    onRemoveItem: currentController.removeItem,
                    onClearCart: currentController.clearCart,
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
