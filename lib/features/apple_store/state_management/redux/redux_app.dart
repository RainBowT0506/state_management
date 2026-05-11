import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'cart_redux.dart';

class ReduxApp extends StatelessWidget {
  const ReduxApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 建立 Store
    final store = Store<CartState>(
      cartReducer,
      initialState: CartState(),
    );

    return StoreProvider<CartState>(
      store: store,
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return StoreConnector<CartState, CartState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return buildAppleStoreFlow(
                    context: context,
                    title: 'Redux',
                    state: state,
                    onAddToCart: (item) => StoreProvider.of<CartState>(context).dispatch(AddToCartAction(item)),
                    onUpdateQuantity: (item, qty) => StoreProvider.of<CartState>(context).dispatch(UpdateQuantityAction(item, qty)),
                    onRemoveItem: (item) => StoreProvider.of<CartState>(context).dispatch(RemoveItemAction(item)),
                    onClearCart: () => StoreProvider.of<CartState>(context).dispatch(ClearCartAction()),
                    cartPageBuilder: (context) => StoreConnector<CartState, CartState>(
                      converter: (store) => store.state,
                      builder: (context, currentState) {
                        return buildCommonCartPage(
                          context: context,
                          state: currentState,
                          onUpdateQuantity: (item, qty) => StoreProvider.of<CartState>(context).dispatch(UpdateQuantityAction(item, qty)),
                          onRemoveItem: (item) => StoreProvider.of<CartState>(context).dispatch(RemoveItemAction(item)),
                          onClearCart: () => StoreProvider.of<CartState>(context).dispatch(ClearCartAction()),
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
