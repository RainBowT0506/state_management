import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/core/models/product.dart';
import '../pages/home_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/order_success_page.dart';

/// 共用的 Apple Store UI 流程構建器
/// 透過傳入狀態 (CartState) 與對應的動作 (Callbacks)，統一管理導航邏輯。
Widget buildAppleStoreFlow({
  required BuildContext context,
  required String title,
  required CartState state,
  required Function(CartItem) onAddToCart,
  required Function(CartItem, int) onUpdateQuantity,
  required Function(CartItem) onRemoveItem,
  required VoidCallback onClearCart,
  required Widget Function(BuildContext) cartPageBuilder,
}) {
  return HomePage(
    stateManagementTitle: title,
    cartItemCount: state.itemCount,
    onProductTap: (product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailPage(
            product: product,
            onAddToCart: onAddToCart,
          ),
        ),
      );
    },
    onCartTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: cartPageBuilder,
        ),
      );
    },
  );
}

/// 建立共用的 CartPage，供各架構在 builder 中呼叫
Widget buildCommonCartPage({
  required BuildContext context,
  required CartState state,
  required Function(CartItem, int) onUpdateQuantity,
  required Function(CartItem) onRemoveItem,
  required VoidCallback onClearCart,
}) {
  return CartPage(
    state: state,
    onUpdateQuantity: onUpdateQuantity,
    onRemoveItem: onRemoveItem,
    onCheckout: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CheckoutPage(
            state: state,
            onComplete: () {
              onClearCart();
              final navigator = Navigator.of(context);
              navigator.popUntil((route) => route.isFirst);
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => OrderSuccessPage(
                    onContinueShopping: () => Navigator.of(context).pop(),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
