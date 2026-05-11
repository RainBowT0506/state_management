import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final int index;
  final Function(int) onUpdateQuantity;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.index,
    required this.onUpdateQuantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

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
                      onChanged: onUpdateQuantity,
                    ),
                    TextButton(
                      onPressed: onRemove,
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
