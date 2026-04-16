import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();

  Future<User> login({required String email, required String password});

  Future<void> logout();
}
