import 'package:flutter/material.dart';
import 'package:state_management/features/apple_store/presentation/pages/home_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/product_detail_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/cart_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/checkout_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/order_success_page.dart';
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
            return ValueListenableBuilder(
              valueListenable: _notifier,
              builder: (context, state, child) {
                return HomePage(
                  stateManagementTitle: 'ValueNotifier',
                  cartItemCount: state.itemCount,
                  onProductTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: product,
                          onAddToCart: (item) => _notifier.addToCart(item),
                        ),
                      ),
                    );
                  },
                  onCartTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          state: state,
                          onUpdateQuantity: (item, qty) => _notifier.updateQuantity(item, qty),
                          onRemoveItem: (item) => _notifier.removeItem(item),
                          onCheckout: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  state: state,
                                  onComplete: () {
                                    _notifier.clearCart();
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
    );
  }
}
