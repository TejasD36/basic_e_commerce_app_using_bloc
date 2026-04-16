import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  static const _validEmail = 'admin@gmail.com';
  static const _validPassword = '123456';

  @override
  Future<bool> isLoggedIn() async {
    return localDataSource.isLoggedIn();
  }

  @override
  Future<User> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == _validEmail && password == _validPassword) {
      await localDataSource.saveLogin(email);

      return User(email: email);
    }

    throw Exception('Invalid email or password');
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }
}
