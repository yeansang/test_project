import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/providers/auth_provider.dart';
import 'package:test_project/providers/comment_provider.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/providers/user_provider.dart';
import 'package:test_project/repositories/comment_repository.dart';

import 'router.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({super.key, required this.postId});
  final int postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final goRoute = ref.read(goRouterProvider);
    final authContext = ref.read(authProvider);
    final postNotifier = ref.read(postProvider.notifier);

    final post = ref
        .read(postProvider)
        .firstWhere((element) => element.id == widget.postId);

    final comments = ref.read(commentProvider)[widget.postId] ?? [];
    final auther = ref.read(userProvider)[post.userId];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goRoute.pop(), icon: const Icon(Icons.arrow_back)),
        actions: [
          if (authContext.currentUser?.id == auther?.id)
            IconButton(
                onPressed: () async {
                  await postNotifier.deletePost(postId: widget.postId);
                  goRoute.pop();
                },
                icon: const Icon(Icons.delete)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Auther: ${auther?.userName}'),
              const Divider(
                thickness: 5,
              ),
              Text(
                post.body,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Divider(
                thickness: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('=======Comment======='),
              const SizedBox(
                height: 20,
              ),
              _commentList(comments: comments)
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentList({required List<Comment> comments}) {
    final List<Widget> commentCells = [];

    for (Comment comment in comments) {
      commentCells.addAll(_commentCell(comment: comment));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: commentCells,
    );
  }

  List<Widget> _commentCell({required Comment comment}) {
    return [
      Text('Title: ${comment.name}\n'),
      Text('email: ${comment.email}'),
      Text('${comment.body}'),
      const Divider(
        thickness: 2,
      ),
    ];
  }
}
