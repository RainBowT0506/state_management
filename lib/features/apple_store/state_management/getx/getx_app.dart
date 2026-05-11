import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'cart_get_controller.dart';

class GetXApp extends StatelessWidget {
  const GetXApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 注入控制器
    final controller = Get.put(CartGetController(), tag: DateTime.now().toString());

    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Obx(() {
              return buildAppleStoreFlow(
                context: context,
                title: 'GetX',
                state: controller.state,
                onAddToCart: controller.addToCart,
                onUpdateQuantity: controller.updateQuantity,
                onRemoveItem: controller.removeItem,
                onClearCart: controller.clearCart,
                cartPageBuilder: (context) => Obx(() {
                  return buildCommonCartPage(
                    context: context,
                    state: controller.state,
                    onUpdateQuantity: controller.updateQuantity,
                    onRemoveItem: controller.removeItem,
                    onClearCart: controller.clearCart,
                  );
                }),
              );
            });
          },
        );
      },
    );
  }
}
