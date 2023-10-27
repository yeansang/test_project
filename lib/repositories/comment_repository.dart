import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'comment_repository.g.dart';

@JsonSerializable()
class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment(
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  );

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/comments')
abstract class CommentRepository {
  factory CommentRepository(Dio dio, {String baseUrl}) = _CommentRepository;

  @GET('/')
  Future<List<Comment>?> getComments(
      {@Query('id') int? id, @Query('postId') int? postId});
}
