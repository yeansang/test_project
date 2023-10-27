import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/pages/router.dart';
import 'package:test_project/repositories/user_repository.dart';

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

    final dio = Dio(); // Provide a dio instance
    dio.options.headers['Demo-Header'] =
        'demo header'; // config your dio headers globally
    final client = UserRepository(dio);

    client
        .getUser(email: 'Sincere@april.biz')
        .then((it) => it?.forEach((element) {
              print(element.email);
            }));
    return MaterialApp.router(
      routerConfig: goRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
