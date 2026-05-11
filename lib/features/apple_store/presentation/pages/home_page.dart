import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import 'package:state_management/core/constants/dummy_data.dart';
import 'package:state_management/core/models/product.dart';
import 'package:state_management/features/apple_store/presentation/widgets/cart_badge.dart';
import 'package:state_management/features/apple_store/presentation/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  final int cartItemCount;
  final String stateManagementTitle;
  final Function(Product) onProductTap;
  final VoidCallback onCartTap;

  const HomePage({
    super.key,
    required this.cartItemCount,
    required this.stateManagementTitle,
    required this.onProductTap,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Store ($stateManagementTitle)',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),
            ),
            actions: [
              IconButton(
                onPressed: onCartTap,
                icon: CartBadge(count: cartItemCount),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = dummyProducts[index];
                  return ProductCard(
                    product: product,
                    index: index,
                    onTap: () => onProductTap(product),
                  );
                },
                childCount: dummyProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
