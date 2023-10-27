import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/providers/comment_provider.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/repositories/post_repository.dart';

import 'router.dart';

class PostData {
  final Post post;
  final int commentCount;

  const PostData({required this.post, required this.commentCount});
}

final postListProvider = FutureProvider<List<PostData>?>((ref) async {
  await ref.read(postProvider.notifier).getPostList();
  await ref.read(commentProvider.notifier).getComments();

  final posts = ref.read(postProvider);
  final comments = ref.read(commentProvider);

  final List<PostData> out = [];

  for (Post post in posts) {
    out.add(PostData(post: post, commentCount: comments[post.id]?.length ?? 0));
  }

  return out;
});

class PostListPage extends ConsumerWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postListState = ref.watch(postListProvider);
    final goRoute = ref.read(goRouterProvider);
    return Scaffold(
      body: postListState.isLoading
          ? const Center(
              child: RefreshProgressIndicator(),
            )
          : Material(
              child: ListView.builder(
                itemCount: postListState.value?.length,
                itemBuilder: (context, index) {
                  final data = postListState.value?[index];
                  return InkWell(
                    onTap: () => goRoute.pushNamed(RouterPath.postDetail.name,
                        params: {'id': '${data?.post.id ?? 0}'}),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                          height: 60,
                          child: Center(
                              child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    data?.post.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Flexible(
                                  child: Text('댓글수: ${data?.commentCount}'))
                            ],
                          ))),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
