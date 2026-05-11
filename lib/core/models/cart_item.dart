import 'package:state_management/core/models/product.dart';

class CartItem {
  final String id;
  final Product product;
  final ProductColor selectedColor;
  final StorageOption selectedStorage;
  final bool hasAppleCare;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedColor,
    required this.selectedStorage,
    this.hasAppleCare = false,
    this.quantity = 1,
  });

  double get unitPrice {
    double price = product.basePrice + selectedStorage.extraPrice;
    if (hasAppleCare) {
      price += product.appleCarePrice;
    }
    return price;
  }

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    int? quantity,
    bool? hasAppleCare,
  }) {
    return CartItem(
      id: id,
      product: product,
      selectedColor: selectedColor,
      selectedStorage: selectedStorage,
      hasAppleCare: hasAppleCare ?? this.hasAppleCare,
      quantity: quantity ?? this.quantity,
    );
  }
}
