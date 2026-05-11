import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/core/models/product.dart';
import 'package:state_management/features/apple_store/presentation/pages/home_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/product_detail_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/cart_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/checkout_page.dart';
import 'package:state_management/features/apple_store/presentation/pages/order_success_page.dart';

class VanillaApp extends StatefulWidget {
  const VanillaApp({super.key});

  @override
  State<VanillaApp> createState() => _VanillaAppState();
}

class _VanillaAppState extends State<VanillaApp> {
  CartState _cartState = CartState();

  void _addToCart(CartItem item) {
    setState(() {
      // Check if item already exists with same options
      final existingIndex = _cartState.items.indexWhere((i) => 
        i.product.id == item.product.id && 
        i.selectedColor.name == item.selectedColor.name && 
        i.selectedStorage.size == item.selectedStorage.size &&
        i.hasAppleCare == item.hasAppleCare
      );

      if (existingIndex >= 0) {
        final List<CartItem> newItems = List.from(_cartState.items);
        newItems[existingIndex].quantity += 1;
        _cartState = _cartState.copyWith(items: newItems);
      } else {
        _cartState = _cartState.copyWith(items: [..._cartState.items, item]);
      }
    });
  }

  void _updateQuantity(CartItem item, int quantity) {
    setState(() {
      final List<CartItem> newItems = _cartState.items.map((i) {
        if (i.id == item.id) {
          return i.copyWith(quantity: quantity);
        }
        return i;
      }).toList();
      _cartState = _cartState.copyWith(items: newItems);
    });
  }

  void _removeItem(CartItem item) {
    setState(() {
      final newItems = _cartState.items.where((i) => i.id != item.id).toList();
      _cartState = _cartState.copyWith(items: newItems);
    });
  }

  void _clearCart() {
    setState(() {
      _cartState = CartState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => HomePage(
            cartItemCount: _cartState.itemCount,
            onProductTap: (product) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: product,
                    onAddToCart: _addToCart,
                  ),
                ),
              );
            },
            onCartTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    state: _cartState,
                    onUpdateQuantity: _updateQuantity,
                    onRemoveItem: (item) {
                      _removeItem(item);
                      // Auto-return if empty is handled by CartPage's builder if we were using a builder
                      // but here we just let the user stay or pop
                    },
                    onCheckout: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            state: _cartState,
                            onComplete: () {
                              _clearCart();
                              // First, pop back to the Home page (closes Checkout and Cart)
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              // Then push the Success page on top of Home
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OrderSuccessPage(
                                    onContinueShopping: () {
                                      Navigator.of(context).pop(); // Returns to Home
                                    },
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
              ).then((_) {
                // If the user returns and the cart is empty, we could pop again but usually staying is fine
                if (_cartState.items.isEmpty && Navigator.canPop(context)) {
                  // This is tricky in vanilla without a proper state listener
                }
              });
            },
          ),
        );
      },
    );
  }
}
