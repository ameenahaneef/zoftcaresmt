part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginButtonPresses extends LoginEvent{
  final String email;
  final String password;

  LoginButtonPresses({required this.email, required this.password});

}
