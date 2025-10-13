import 'package:bloc/bloc.dart';
import 'package:eduid/core/storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<Logout>((event, emit) async {
      emit(LogoutLoading());
      try {
        final storage = SecureStorage.instance.storage;
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        await storage.delete(key: 'user');

        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailed(messsage: e.toString()));
      }
    });
  }
}
