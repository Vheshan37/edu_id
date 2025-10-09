import 'package:eduid/features/auth/data/datasource/user_remote_data_source.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>> requestLogin();
  Future<Map<String, dynamic>> verifyToken();
}

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Map<String, dynamic>> requestLogin() {
    return userRemoteDataSource.requestLogin();
  }

  @override
  Future<Map<String, dynamic>> verifyToken() {
    return userRemoteDataSource.verifyToken();
  }
}
