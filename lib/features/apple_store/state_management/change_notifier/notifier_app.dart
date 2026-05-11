import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'cart_change_notifier.dart';

class NotifierApp extends StatelessWidget {
  const NotifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 ChangeNotifierProvider 將 Notifier 注入到 Widget 樹中
    return ChangeNotifierProvider(
      create: (_) => CartChangeNotifier(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              // 使用 Consumer 來監聽 Notifier 的變化並重新建構 UI
              return Consumer<CartChangeNotifier>(
                builder: (context, notifier, child) {
                  return buildAppleStoreFlow(
                    context: context,
                    title: 'ChangeNotifier',
                    state: notifier.state,
                    onAddToCart: notifier.addToCart,
                    onUpdateQuantity: notifier.updateQuantity,
                    onRemoveItem: notifier.removeItem,
                    onClearCart: notifier.clearCart,
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
