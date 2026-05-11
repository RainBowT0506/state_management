import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final List<ProductColor> availableColors;
  final List<StorageOption> storageOptions;
  final bool appleCareAvailable;
  final double appleCarePrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.availableColors,
    required this.storageOptions,
    this.appleCareAvailable = true,
    this.appleCarePrice = 199.0,
  });
}

class ProductColor {
  final String name;
  final Color color;
  final String imageUrl;

  ProductColor({
    required this.name,
    required this.color,
    required this.imageUrl,
  });
}

class StorageOption {
  final String size;
  final double extraPrice;

  StorageOption({
    required this.size,
    required this.extraPrice,
  });
}
