import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project/pages/post_detail_page.dart';
import 'package:test_project/pages/post_list_page.dart';

import 'login_page.dart';

Widget slideTransition(context, animation, secondaryAnimation, child) =>
    SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOutQuart)),
        ),
        child: child);

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/login', routes: [
    /// login
    GoRoute(
      path: RouterPath.login.path,
      name: RouterPath.login.name,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        transitionDuration: const Duration(milliseconds: 500),
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: slideTransition,
      ),
    ),

    /// post list
    GoRoute(
      path: RouterPath.postList.path,
      name: RouterPath.postList.name,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        transitionDuration: const Duration(milliseconds: 500),
        key: state.pageKey,
        child: const PostListPage(),
        transitionsBuilder: slideTransition,
      ),
    ),

    /// post detail
    GoRoute(
      path: RouterPath.postDetail.path,
      name: RouterPath.postDetail.name,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        transitionDuration: const Duration(milliseconds: 500),
        key: state.pageKey,
        child: PostDetailPage(postId: int.parse(state.params['id'] ?? '1')),
        transitionsBuilder: slideTransition,
      ),
    ),
  ]);
});

enum RouterPath {
  login('/login', 'login'),
  postList('/post_list', 'post_list'),
  postDetail('/post/:id', 'post');

  const RouterPath(this.path, this.name);
  final String path;
  final String name;
}
