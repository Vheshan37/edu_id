import 'package:eduid/core/exception/login_exception.dart';
import 'package:eduid/features/auth/data/datasource/user_remote_data_source.dart';
import 'package:eduid/features/auth/data/model/user_model.dart';
import 'package:eduid/features/auth/domain/repository/user_repository.dart';
import 'package:eduid/features/auth/domain/usecase/request_login.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RequestLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final useCase = RequestLoginUseCase(
          userRepository: UserRepositoryImpl(
            userRemoteDataSource: UserRemoteDataSourceImpl(
              client: http.Client(),
              email: event.email,
              password: event.password,
            ),
          ),
        );

        final response = await useCase.call();

        debugPrint('BLoC Response: $response');
        emit(AuthAuthenticated(userModel: UserModel.fromJson(json: response['user'])));
      } on LoginException catch (e) {
        emit(UnAuthenticated(message: e.message, title: e.title));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
