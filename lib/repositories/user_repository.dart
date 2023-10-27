import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  @JsonKey(name: 'username')
  final String userName;

  const User(
    this.id,
    this.email,
    this.userName,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/users')
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/')
  Future<List<User>?> getUser(
      {@Query('email') String? email, @Query('id') int? id});
}
