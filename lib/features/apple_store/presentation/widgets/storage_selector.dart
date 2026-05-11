import 'package:flutter/material.dart';
import 'package:state_management/core/models/product.dart';

class StorageSelector extends StatelessWidget {
  final List<StorageOption> options;
  final StorageOption selectedOption;
  final ValueChanged<StorageOption> onOptionSelected;

  const StorageSelector({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Storage. How much space do you need?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final storage = options[index];
            final isSelected = selectedOption == storage;
            return GestureDetector(
              onTap: () => onOptionSelected(storage),
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
      ],
    );
  }
}
