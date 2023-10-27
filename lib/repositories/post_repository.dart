import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'post_repository.g.dart';

@JsonSerializable()
class Post {
  final int id;
  @JsonKey(name: 'userId')
  final int userId;
  final String title;
  final String body;

  const Post(this.id, this.userId, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @GET('/')
  Future<List<Post>?> getPosts({@Query('id') int? id});

  @DELETE('/{id}')
  Future<void> deletePost({@Path('id') required int id});
}
