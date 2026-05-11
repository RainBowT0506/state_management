import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_store_flow_builder.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'cart_cubit.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cubit = context.read<CartCubit>();
                  
                  return buildAppleStoreFlow(
                    context: context,
                    title: 'BLoC / Cubit',
                    state: state,
                    onAddToCart: cubit.addToCart,
                    onUpdateQuantity: cubit.updateQuantity,
                    onRemoveItem: cubit.removeItem,
                    onClearCart: cubit.clearCart,
                    cartPageBuilder: (context) => BlocBuilder<CartCubit, CartState>(
                      builder: (context, currentState) {
                        return buildCommonCartPage(
                          context: context,
                          state: currentState,
                          onUpdateQuantity: cubit.updateQuantity,
                          onRemoveItem: cubit.removeItem,
                          onClearCart: cubit.clearCart,
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
