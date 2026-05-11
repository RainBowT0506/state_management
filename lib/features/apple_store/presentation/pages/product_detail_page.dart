import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/product.dart';
import 'package:state_management/core/models/cart_item.dart';
import 'package:state_management/features/apple_store/presentation/widgets/color_selector.dart';
import 'package:state_management/features/apple_store/presentation/widgets/storage_selector.dart';
import 'package:state_management/features/apple_store/presentation/widgets/apple_care_tile.dart';

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
                  
                  ColorSelector(
                    colors: widget.product.availableColors,
                    selectedColor: selectedColor,
                    onColorSelected: (color) => setState(() => selectedColor = color),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  StorageSelector(
                    options: widget.product.storageOptions,
                    selectedOption: selectedStorage,
                    onOptionSelected: (option) => setState(() => selectedStorage = option),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Apple Care+
                  if (widget.product.appleCareAvailable)
                    AppleCareTile(
                      price: widget.product.appleCarePrice,
                      isSelected: hasAppleCare,
                      onTap: () => setState(() => hasAppleCare = !hasAppleCare),
                    ),
                  
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
