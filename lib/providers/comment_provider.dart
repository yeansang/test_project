import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/repositories/comment_repository.dart';

class CommentNotifier extends StateNotifier<Map<int, List<Comment>>> {
  CommentNotifier() : super({});
  final Dio dio = Dio();
  Future<List<Comment>> getComments({int? postId}) async {
    if (postId != null && state[postId] != null) {
      return state[postId]!;
    }
    final comments = await CommentRepository(dio).getComments(postId: postId);
    if (postId == null) {
      final Map<int, List<Comment>> out = {};
      for (Comment comment in comments ?? []) {
        if (out[comment.postId] == null) {
          out[comment.postId] = [];
        }
        out[comment.postId]?.add(comment);
      }
      state = out;
      return comments ?? [];
    }

    final temp = Map<int, List<Comment>>.from(state);
    temp[postId] = comments ?? [];
    state = temp;
    return comments ?? [];
  }
}

final commentProvider =
    StateNotifierProvider<CommentNotifier, Map<int, List<Comment>>>((ref) {
  return CommentNotifier();
});
