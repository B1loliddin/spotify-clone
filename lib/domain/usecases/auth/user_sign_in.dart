import 'package:spotify_clone/core/errors/failure.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

class UserSignIn implements UseCase<Null, UserSignInParams> {
  final AuthRepository authRepository;

  const UserSignIn({required this.authRepository});

  @override
  Future<DataState> call(UserSignInParams params) async {
    try {
      await authRepository.signIn(
        email: params.email,
        password: params.password,
      );

      return const DataSuccess(null);
    } on Failure catch (e) {
      return DataFailed(e);
    }
  }
}

class UserSignInParams {
  final String email;
  final String password;

  const UserSignInParams({
    required this.email,
    required this.password,
  });
}
