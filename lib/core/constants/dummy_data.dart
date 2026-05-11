import 'package:flutter/material.dart';
import 'package:state_management/core/models/product.dart';

final List<Product> dummyProducts = [
  Product(
    id: 'iphone-15-pro',
    name: 'iPhone 15 Pro',
    description: 'Forged in titanium and featuring the groundbreaking A17 Pro chip, a customizable Action button, and a more versatile Pro camera system.',
    basePrice: 999.0,
    availableColors: [
      ProductColor(name: 'Natural Titanium', color: const Color(0xFFB9B4A7), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692846363993'),
      ProductColor(name: 'Blue Titanium', color: const Color(0xFF2B3039), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-bluetitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692846360609'),
      ProductColor(name: 'White Titanium', color: const Color(0xFFF2F1ED), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-whitetitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692846367180'),
      ProductColor(name: 'Black Titanium', color: const Color(0xFF242526), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-blacktitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692846357018'),
    ],
    storageOptions: [
      StorageOption(size: '128GB', extraPrice: 0.0),
      StorageOption(size: '256GB', extraPrice: 100.0),
      StorageOption(size: '512GB', extraPrice: 300.0),
      StorageOption(size: '1TB', extraPrice: 500.0),
    ],
  ),
  Product(
    id: 'iphone-15',
    name: 'iPhone 15',
    description: 'Dynamic Island, 48MP Main camera, and USB-C. All in a durable color-infused glass and aluminum design.',
    basePrice: 799.0,
    availableColors: [
      ProductColor(name: 'Pink', color: const Color(0xFFFEE1D7), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-pink?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777322'),
      ProductColor(name: 'Yellow', color: const Color(0xFFFEF4A2), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-yellow?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777972'),
      ProductColor(name: 'Green', color: const Color(0xFFD4EBD1), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-green?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777440'),
      ProductColor(name: 'Blue', color: const Color(0xFFD3E0E9), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-blue?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777218'),
      ProductColor(name: 'Black', color: const Color(0xFF333738), imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-black?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777971'),
    ],
    storageOptions: [
      StorageOption(size: '128GB', extraPrice: 0.0),
      StorageOption(size: '256GB', extraPrice: 100.0),
      StorageOption(size: '512GB', extraPrice: 300.0),
    ],
  ),
];
