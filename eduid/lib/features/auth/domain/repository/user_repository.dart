import 'package:eduid/features/auth/data/datasource/user_remote_data_source.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>> requestLogin();
}

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Map<String, dynamic>> requestLogin() {
    return userRemoteDataSource.requestLogin();
  }
}
