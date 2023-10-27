class UserRepository {
  UserRepository._privateConstructor();
  static final UserRepository _instance = UserRepository._privateConstructor();
  factory UserRepository() {
    return _instance;
  }
}
