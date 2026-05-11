import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/product.dart';
import 'package:state_management/core/models/cart_item.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final Function(CartItem) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductColor selectedColor;
  late StorageOption selectedStorage;
  bool hasAppleCare = false;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product.availableColors[0];
    selectedStorage = widget.product.storageOptions[0];
  }

  double get totalPrice {
    double price = widget.product.basePrice + selectedStorage.extraPrice;
    if (hasAppleCare) {
      price += widget.product.appleCarePrice;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            FadeInDown(
              child: Container(
                height: 400,
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                color: const Color(0xFFF5F5F7),
                child: Image.network(
                  selectedColor.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInLeft(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Color Selection
                  const Text(
                    'Finish. Pick your favorite.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.product.availableColors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final colorOption = widget.product.availableColors[index];
                        final isSelected = selectedColor == colorOption;
                        return GestureDetector(
                          onTap: () => setState(() => selectedColor = colorOption),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorOption.color,
                              border: Border.all(
                                color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: const Color(0xFF007AFF).withOpacity(0.3),
                                    blurRadius: 10,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    selectedColor.name,
                    style: const TextStyle(fontSize: 14, color: Colors.black54, height: 2),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Storage Selection
                  const Text(
                    'Storage. How much space do you need?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.product.storageOptions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final storage = widget.product.storageOptions[index];
                      final isSelected = selectedStorage == storage;
                      return GestureDetector(
                        onTap: () => setState(() => selectedStorage = storage),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF007AFF) : Colors.black12,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                storage.size,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              Text(
                                storage.extraPrice == 0 
                                  ? 'Included' 
                                  : '+\$${storage.extraPrice.toInt()}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Apple Care+
                  if (widget.product.appleCareAvailable) ...[
                    const Text(
                      'AppleCare+ coverage. Protect your new iPhone.',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => setState(() => hasAppleCare = !hasAppleCare),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: hasAppleCare ? const Color(0xFF007AFF) : Colors.black12,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.security, color: Colors.red, size: 30),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AppleCare+',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Coverage for accidental damage',
                                    style: TextStyle(fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '+\$${widget.product.appleCarePrice.toInt()}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total'),
                Text(
                  currencyFormat.format(totalPrice),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  final cartItem = CartItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    product: widget.product,
                    selectedColor: selectedColor,
                    selectedStorage: selectedStorage,
                    hasAppleCare: hasAppleCare,
                  );
                  widget.onAddToCart(cartItem);
                  Navigator.pop(context);
                },
                child: const Text('Add to Bag'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
