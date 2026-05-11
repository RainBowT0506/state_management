import 'package:flutter/material.dart';
import 'package:state_management/core/models/product.dart';

class ColorSelector extends StatelessWidget {
  final List<ProductColor> colors;
  final ProductColor selectedColor;
  final ValueChanged<ProductColor> onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Finish. Pick your favorite.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final colorOption = colors[index];
              final isSelected = selectedColor == colorOption;
              return GestureDetector(
                onTap: () => onColorSelected(colorOption),
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
      ],
    );
  }
}
