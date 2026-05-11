import 'package:flutter/material.dart';

class AppleCareTile extends StatelessWidget {
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const AppleCareTile({
    super.key,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AppleCare+ coverage. Protect your new iPhone.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onTap,
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
                  '+\$${price.toInt()}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
