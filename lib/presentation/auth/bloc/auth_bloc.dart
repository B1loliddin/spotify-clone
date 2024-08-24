import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/domain/usecases/auth/user_sign_in.dart';
import 'package:spotify_clone/domain/usecases/auth/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(const AuthInitial()) {
    on<AuthEvent>((_, emit) => const AuthLoading());
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final result = await _userSignUp(
      UserSignUpParams(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      ),
    );

    if (result is DataSuccess) {
      emit(const AuthSignUpSuccess());
    } else if (result is DataFailed) {
      emit(AuthFailure(message: result.failure!.message));
    }
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final result = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    if (result is DataSuccess) {
      emit(const AuthSignInSuccess());
    } else if (result is DataFailed) {
      emit(AuthFailure(message: result.failure!.message));
    }
  }
}
