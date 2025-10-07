import 'package:eduid/features/auth/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestLogin requestLogin;

  AuthBloc() : super(AuthInitial()) {
    on<RequestLogin>((event, emit) {
    });
  }
}
