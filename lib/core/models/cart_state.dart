import 'cart_item.dart';

class CartState {
  final List<CartItem> items;
  final String? couponCode;
  final double discount;

  CartState({
    this.items = const [],
    this.couponCode,
    this.discount = 0.0,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal - discount;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<CartItem>? items,
    String? couponCode,
    double? discount,
  }) {
    return CartState(
      items: items ?? this.items,
      couponCode: couponCode ?? this.couponCode,
      discount: discount ?? this.discount,
    );
  }
}
