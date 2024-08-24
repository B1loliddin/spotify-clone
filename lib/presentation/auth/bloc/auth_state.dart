part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

final class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess();
}

final class AuthSignInSuccess extends AuthState {
  const AuthSignInSuccess();
}
