import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/presentation/widgets/cart_item_tile.dart';
import 'package:state_management/features/apple_store/presentation/widgets/summary_row.dart';

class CartPage extends StatelessWidget {
  final CartState state;
  final Function(CartItem, int) onUpdateQuantity;
  final Function(CartItem) onRemoveItem;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.state,
    required this.onUpdateQuantity,
    required this.onRemoveItem,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    if (state.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bag')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.black12),
              const SizedBox(height: 16),
              const Text(
                'Your bag is empty.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Items you add to your bag will appear here.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bag')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review your bag.',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Free delivery and free returns.',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 32),
              
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const Divider(height: 48),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return CartItemTile(
                    item: item,
                    index: index,
                    onUpdateQuantity: (val) => onUpdateQuantity(item, val),
                    onRemove: () => onRemoveItem(item),
                  );
                },
              ),
              
              const Divider(height: 64),
              
              // Summary
              Column(
                children: [
                  SummaryRow(label: 'Subtotal', value: currencyFormat.format(state.subtotal)),
                  const SizedBox(height: 12),
                  SummaryRow(label: 'Shipping', value: 'FREE'),
                  const SizedBox(height: 12),
                  SummaryRow(label: 'Estimated Tax', value: '\$0.00'),
                  const Divider(height: 32),
                  SummaryRow(
                    label: 'Total', 
                    value: currencyFormat.format(state.total),
                    isTotal: true,
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onCheckout,
                child: const Text('Check Out'),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
