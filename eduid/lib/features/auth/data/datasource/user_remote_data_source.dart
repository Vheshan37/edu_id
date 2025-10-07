import 'package:http/http.dart' as http show Client;

abstract class UserRemoteDataSource{
  Future<Map<String, dynamic>> requestLogin();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource{
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> requestLogin() {
    throw UnimplementedError();
  }

}
