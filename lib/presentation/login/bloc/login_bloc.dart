import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoftcares_mt/data/apiservices/login_service.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPresses>((event, emit) async {
      if (state is! LoginLoading) {
        emit(LoginLoading());
        try {
          final response = await ApiService().login(event.email, event.password);

          if (response.data.accessToken.isEmpty) {
            emit(LoginSessionExpired(message: 'Session expired. Please log in again.'));
          } else {
            emit(LoginSuccess(accessToken: response.data.accessToken));
          }
        } catch (e) {
          emit(LoginFailure(error: e.toString()));
        }
      }
    });
  }
}
