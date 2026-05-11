import 'package:flutter/material.dart';
import 'core/theme/apple_theme.dart';
import 'features/apple_store/state_management/vanilla/vanilla_app.dart';

void main() {
  runApp(const AppleStorePlayground());
}

class AppleStorePlayground extends StatelessWidget {
  const AppleStorePlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Store Playground',
      theme: AppleTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const VanillaApp(),
    );
  }
}
