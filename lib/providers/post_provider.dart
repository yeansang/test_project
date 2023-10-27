import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/repositories/post_repository.dart';

class PostNotifier extends StateNotifier<List<Post>> {
  PostNotifier() : super([]);

  final dio = Dio();

  Future<void> getPostList() async {
    state = await PostRepository(dio).getPosts() ?? [];
  }
}

final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier();
});
