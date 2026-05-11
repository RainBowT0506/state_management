import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/features/apple_store/presentation/pages/home_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/product_detail_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/cart_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/checkout_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/order_success_page.dart';
import 'cart_change_notifier.dart';

class NotifierApp extends StatelessWidget {
  const NotifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartChangeNotifier(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return Consumer<CartChangeNotifier>(
                builder: (context, notifier, child) {
                  return HomePage(
                    stateManagementTitle: 'ChangeNotifier',
                    cartItemCount: notifier.state.itemCount,
                    onProductTap: (product) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: product,
                            onAddToCart: (item) => notifier.addToCart(item),
                          ),
                        ),
                      );
                    },
                    onCartTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            state: notifier.state,
                            onUpdateQuantity: (item, qty) => notifier.updateQuantity(item, qty),
                            onRemoveItem: (item) => notifier.removeItem(item),
                            onCheckout: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(
                                    state: notifier.state,
                                    onComplete: () {
                                      notifier.clearCart();
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      Navigator.of(context).push(
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
                          ),
                        ),
                      );
                    },
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
