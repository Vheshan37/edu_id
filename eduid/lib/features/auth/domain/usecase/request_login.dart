import 'package:eduid/features/auth/domain/repository/user_repository.dart';

class RequestLoginUseCase {
  final UserRepository userRepository;

  RequestLoginUseCase({required this.userRepository});

  Future<Map<String, dynamic>> call() {
    return userRepository.requestLogin();
  }
}
