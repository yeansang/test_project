import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/providers/auth_provider.dart';
import 'package:toast/toast.dart';

import 'router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailTextController = TextEditingController();
  @override
  void initState() {
    final authContext = ref.read(authProvider);
    final goRoute = ref.read(goRouterProvider);
    if (authContext.currentUser != null) {
      goRoute.goNamed(
        RouterPath.postList.name,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
    // final authContext = ref.watch(authProvider);
    final goRoute = ref.read(goRouterProvider);
    ToastContext().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email input'),
                  Expanded(
                    child: TextField(
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'email',
                      ),
                      onSubmitted: (value) async {
                        final result = await authNotifier.signIn(email: value);
                        if (result) {
                          goRoute.goNamed(
                            RouterPath.postList.name,
                          );
                        } else {
                          Toast.show('Login fail');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
