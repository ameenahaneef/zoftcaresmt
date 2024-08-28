part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState{}

final class LoginSuccess extends LoginState{
  final String accessToken;

  LoginSuccess({required this.accessToken});
  
}

final class LoginFailure extends LoginState{
  final String error;
  LoginFailure({required this.error});
}

class LoginSessionExpired extends LoginState {
   final String message;
  LoginSessionExpired({required this.message});
}