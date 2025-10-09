import 'package:eduid/app/flutter_secure_storage.dart';
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

        // flutter secure storage.
        // save login jwt token here...
        final storage = SecureStorage.instance.storage;
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        debugPrint('JWT are deleted');
        await storage.write(key: 'accessToken', value: response['token']);
        await storage.write(
          key: 'refreshToken',
          value: response['refreshToken'],
        );

        final userModel = UserModel.fromJson(json: response['user']);
        await storage.write(key: 'user', value: userModel.toString());
        debugPrint('New JWT are saved');

        emit(AuthAuthenticated(userModel: userModel));
      } on LoginException catch (e) {
        debugPrint(e.toString());
        emit(UnAuthenticated(message: e.message, title: e.title));
      } catch (e) {
        debugPrint(e.toString());
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
