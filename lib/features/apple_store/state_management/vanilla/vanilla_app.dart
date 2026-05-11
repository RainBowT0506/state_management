import 'package:flutter/material.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';

class VanillaApp extends StatefulWidget {
  const VanillaApp({super.key});

  @override
  State<VanillaApp> createState() => _VanillaAppState();
}

class _VanillaAppState extends State<VanillaApp> {
  // 全域購物車狀態，儲存於最頂層 Widget
  CartState _cartState = CartState();

  // 用於通知子路由（如購物車頁面）更新的 ValueNotifier
  final ValueNotifier<CartState> _cartNotifier = ValueNotifier(CartState());

  @override
  void dispose() {
    _cartNotifier.dispose();
    super.dispose();
  }

  // 新增商品到購物車
  void _addToCart(CartItem item) {
    setState(() {
      // 檢查購物車中是否已存在相同規格的商品
      final existingIndex = _cartState.items.indexWhere((i) => 
        i.product.id == item.product.id && 
        i.selectedColor.name == item.selectedColor.name && 
        i.selectedStorage.size == item.selectedStorage.size &&
        i.hasAppleCare == item.hasAppleCare
      );

      if (existingIndex >= 0) {
        // 如果存在，則增加數量
        final List<CartItem> newItems = List.from(_cartState.items);
        newItems[existingIndex] = newItems[existingIndex].copyWith(
          quantity: newItems[existingIndex].quantity + 1,
        );
        _cartState = _cartState.copyWith(items: newItems);
      } else {
        // 如果不存在，則新增項目
        _cartState = _cartState.copyWith(items: [..._cartState.items, item]);
      }
      _cartNotifier.value = _cartState;
    });
  }

  // 更新購物車商品數量
  void _updateQuantity(CartItem item, int quantity) {
    setState(() {
      final List<CartItem> newItems = _cartState.items.map((i) {
        if (i.id == item.id) {
          return i.copyWith(quantity: quantity);
        }
        return i;
      }).toList();
      _cartState = _cartState.copyWith(items: newItems);
      _cartNotifier.value = _cartState;
    });
  }

  // 從購物車移除項目
  void _removeItem(CartItem item) {
    setState(() {
      final newItems = _cartState.items.where((i) => i.id != item.id).toList();
      _cartState = _cartState.copyWith(items: newItems);
      _cartNotifier.value = _cartState;
    });
  }

  // 清空購物車（用於結帳完成後）
  void _clearCart() {
    setState(() {
      _cartState = CartState();
      _cartNotifier.value = _cartState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => buildAppleStoreFlow(
            context: context,
            title: 'Vanilla',
            state: _cartState,
            onAddToCart: _addToCart,
            onUpdateQuantity: _updateQuantity,
            onRemoveItem: _removeItem,
            onClearCart: _clearCart,
            cartPageBuilder: (context) => ValueListenableBuilder(
              valueListenable: _cartNotifier,
              builder: (context, currentState, _) {
                return buildCommonCartPage(
                  context: context,
                  state: currentState,
                  onUpdateQuantity: _updateQuantity,
                  onRemoveItem: _removeItem,
                  onClearCart: _clearCart,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
