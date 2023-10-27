class PostRepository {
  PostRepository._privateConstructor();
  static final PostRepository _instance = PostRepository._privateConstructor();
  factory PostRepository() {
    return _instance;
  }
}
