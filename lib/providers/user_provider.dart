import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/repositories/user_repository.dart';

class UserNotifier extends StateNotifier<Map<int, User>> {
  UserNotifier() : super({});

  final dio = Dio();

  Future<User?> getUser({required int userId}) async {
    if (state[userId] != null) return state[userId];

    final users = await UserRepository(dio).getUser(id: userId);

    if (users?.first != null) {
      final temp = Map<int, User>.from(state);
      temp[users!.first.id] = users.first;
      state = temp;
    }

    return users?.first;
  }

  Future<void> getUsers() async {
    final users = await UserRepository(dio).getUser();

    final Map<int, User> out = {};
    for (User user in users ?? []) {
      out[user.id] = user;
    }
    state = out;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, Map<int, User>>((ref) {
  final notifier = UserNotifier();
  notifier.getUsers();
  return notifier;
});
