import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../pages/home_page.dart';
import '../../state_management/vanilla/vanilla_app.dart';
import '../../state_management/notifier/notifier_app.dart';
import '../../state_management/notifier/value_notifier_app.dart';

class ArchitectureSelectorPage extends StatelessWidget {
  const ArchitectureSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apple Store',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'State Management Playground',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Select an Architecture',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _ArchitectureCard(
                      title: 'No State Management',
                      subtitle: 'setState & Property Drilling',
                      color: Colors.grey[800]!,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VanillaApp())),
                    ),
                    const SizedBox(height: 16),
                    _ArchitectureCard(
                      title: 'ChangeNotifier',
                      subtitle: 'Provider + ChangeNotifier',
                      color: Colors.blue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifierApp())),
                    ),
                    const SizedBox(height: 16),
                    _ArchitectureCard(
                      title: 'ValueNotifier',
                      subtitle: 'Native ValueNotifier + ValueListenableBuilder',
                      color: Colors.purple,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ValueNotifierApp())),
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

class _ArchitectureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ArchitectureCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
