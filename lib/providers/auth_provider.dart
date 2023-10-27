import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/repositories/user_repository.dart';

class AuthContext {
  final User? currentUser;
  const AuthContext(this.currentUser);
}

class AuthNotifier extends StateNotifier<AuthContext> {
  AuthNotifier({required User? currentUser}) : super(AuthContext(currentUser));

  final Dio dio = Dio();

  Future<void> init() async {
    await _getAuth();
  }

  Future<bool> signIn({required String email}) async {
    final users = await UserRepository(dio).getUser(email: email);
    if (users?.isNotEmpty ?? false) {
      state = AuthContext(users!.first);
      _storeAuth();
      return true;
    }
    return false;
  }

  Future<void> _storeAuth() async {
    final storage = await SharedPreferences.getInstance();
    if (state.currentUser?.email != null) {
      storage.setString('auth', state.currentUser!.email);
    }
  }

  Future<void> _getAuth() async {
    final storage = await SharedPreferences.getInstance();
    if (storage.containsKey('auth')) {
      final email = storage.getString('auth');
      await signIn(email: email ?? '');
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthContext>((ref) {
  final notifier = AuthNotifier(currentUser: null);
  notifier.init();
  return notifier;
});
