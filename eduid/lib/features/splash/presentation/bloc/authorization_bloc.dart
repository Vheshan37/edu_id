import 'package:bloc/bloc.dart';
import 'package:eduid/app/flutter_secure_storage.dart';
import 'package:eduid/features/auth/data/datasource/user_remote_data_source.dart';
import 'package:eduid/features/auth/domain/repository/user_repository.dart';
import 'package:eduid/features/auth/domain/usecase/verify_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<RequestAuthorization>((event, emit) async {
      emit(AuthorizationLoading());
      try {
        // get the secure storage
        final storage = SecureStorage.instance.storage;

        // validate access token, if expired then refresh token
        // send request to server
        final verifyToken = VerifyToken(
          userRepository: UserRepositoryImpl(
            userRemoteDataSource: UserRemoteDataSourceImpl(
              client: http.Client(),
            ),
          ),
        );

        final response = await verifyToken.call();
        debugPrint('Authorization BLoC Response: $response');

        if(response['state'] =="valid"){
          emit(Authorized());
          return;
        }

        // final storage = SecureStorage.instance.storage;
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        debugPrint('JWT are deleted');
        await storage.write(key: 'accessToken', value: response['token']);
        await storage.write(
          key: 'refreshToken',
          value: response['refreshToken'],
        );
        debugPrint('New JWT are saved');

        // send emit
        emit(Authorized());
      } catch (e) {
        emit(UnAuthorized());
      }
    });
  }
}
