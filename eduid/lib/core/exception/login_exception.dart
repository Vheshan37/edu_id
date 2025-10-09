class LoginException {
  final String title;
  final String message;

  LoginException({required this.title, required this.message});

  @override
  String toString() => '$title: $message';
}
