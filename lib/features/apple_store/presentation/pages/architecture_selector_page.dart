import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../pages/home_page.dart';
import '../../state_management/vanilla/vanilla_app.dart';
import '../../state_management/change_notifier/notifier_app.dart';
import '../../state_management/value_notifier/value_notifier_app.dart';
import '../../state_management/provider/provider_app.dart';
import '../../state_management/riverpod/riverpod_app.dart';
import '../widgets/architecture_card.dart';

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
                    ArchitectureCard(
                      title: 'No State Management',
                      subtitle: 'setState & Property Drilling',
                      color: Colors.grey[800]!,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VanillaApp())),
                    ),
                    const SizedBox(height: 16),
                    ArchitectureCard(
                      title: 'ChangeNotifier',
                      subtitle: 'Provider + ChangeNotifier',
                      color: Colors.blue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifierApp())),
                    ),
                    const SizedBox(height: 16),
                    ArchitectureCard(
                      title: 'ValueNotifier',
                      subtitle: 'Native ValueNotifier + ValueListenableBuilder',
                      color: Colors.purple,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ValueNotifierApp())),
                    ),
                    const SizedBox(height: 16),
                    ArchitectureCard(
                      title: 'Provider',
                      subtitle: 'Advanced Provider usage (context.watch)',
                      color: Colors.indigo,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderApp())),
                    ),
                    const SizedBox(height: 16),
                    ArchitectureCard(
                      title: 'Riverpod',
                      subtitle: 'Modern Notifier + ProviderScope',
                      color: Colors.teal,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RiverpodApp())),
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
