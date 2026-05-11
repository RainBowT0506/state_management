import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import 'package:state_management/core/models/cart_state.dart';
import 'package:state_management/features/apple_store/presentation/widgets/payment_option_tile.dart';

class CheckoutPage extends StatefulWidget {
  final CartState state;
  final VoidCallback onComplete;

  const CheckoutPage({super.key, required this.state, required this.onComplete});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPayment = 0; // 0: Apple Pay, 1: Card, 2: PayPal

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: const Text(
                  'How would you like to pay?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32),
              
              PaymentOptionTile(
                title: 'Apple Pay',
                icon: Icons.apple,
                isSelected: selectedPayment == 0,
                onTap: () => setState(() => selectedPayment = 0),
              ),
              const SizedBox(height: 16),
              PaymentOptionTile(
                title: 'Credit or Debit Card',
                icon: Icons.credit_card,
                isSelected: selectedPayment == 1,
                onTap: () => setState(() => selectedPayment = 1),
              ),
              const SizedBox(height: 16),
              PaymentOptionTile(
                title: 'PayPal',
                icon: Icons.payment,
                isSelected: selectedPayment == 2,
                onTap: () => setState(() => selectedPayment = 2),
              ),
              
              const SizedBox(height: 48),
              
              const Text(
                'Shipping Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text('1 Infinite Loop, Cupertino, CA 95014, USA'),
                    ),
                    Icon(Icons.chevron_right, color: Colors.black26),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(currencyFormat.format(widget.state.total), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Simulate processing
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.black)),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.of(context, rootNavigator: true).pop(); // Use rootNavigator to be sure
                            widget.onComplete();
                          }
                        });
                      },
                      child: Text(selectedPayment == 0 ? 'Pay with Apple Pay' : 'Place Order'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
