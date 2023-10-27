import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/pages/router.dart';

void main() {
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRoute = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
