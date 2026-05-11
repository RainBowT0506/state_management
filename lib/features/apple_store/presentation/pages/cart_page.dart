import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/core/models/cart_item.dart';

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
                  return FadeInLeft(
                    delay: Duration(milliseconds: 100 * index),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.network(item.selectedColor.imageUrl),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${item.selectedColor.name} | ${item.selectedStorage.size}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              if (item.hasAppleCare)
                                const Text(
                                  'with AppleCare+',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _QuantitySelector(
                                    quantity: item.quantity,
                                    onChanged: (val) => onUpdateQuantity(item, val),
                                  ),
                                  TextButton(
                                    onPressed: () => onRemoveItem(item),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text('Remove', style: TextStyle(color: Color(0xFF007AFF), fontSize: 14)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              currencyFormat.format(item.totalPrice),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              const Divider(height: 64),
              
              // Summary
              Column(
                children: [
                  _SummaryRow(label: 'Subtotal', value: currencyFormat.format(state.subtotal)),
                  const SizedBox(height: 12),
                  _SummaryRow(label: 'Shipping', value: 'FREE'),
                  const SizedBox(height: 12),
                  _SummaryRow(label: 'Estimated Tax', value: '\$0.00'),
                  const Divider(height: 32),
                  _SummaryRow(
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

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const _QuantitySelector({required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
            icon: const Icon(Icons.remove, size: 14),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          IconButton(
            onPressed: () => onChanged(quantity + 1),
            icon: const Icon(Icons.add, size: 14),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
