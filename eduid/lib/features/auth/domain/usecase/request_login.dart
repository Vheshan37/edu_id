import 'package:eduid/features/auth/domain/repository/user_repository.dart';

class RequestLogin {
  final UserRepository userRepository;

  RequestLogin({required this.userRepository});

  Future<Map<String, dynamic>> call() {
    return userRepository.requestLogin();
  }
}
