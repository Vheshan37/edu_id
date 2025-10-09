import 'package:eduid/features/auth/domain/repository/user_repository.dart';

class VerifyToken{
  final UserRepository userRepository;

  VerifyToken({required this.userRepository});

  Future<Map<String, dynamic>> call(){
    return userRepository.verifyToken();
  }
}