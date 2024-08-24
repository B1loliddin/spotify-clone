import 'package:spotify_clone/core/errors/failure.dart';
import 'package:spotify_clone/core/resources/data_state.dart';
import 'package:spotify_clone/core/usecase/usecase.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

class UserSignUp implements UseCase<Null, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp({required this.authRepository});

  @override
  Future<DataState> call(UserSignUpParams params) async {
    try {
      await authRepository.signUp(
        fullName: params.fullName,
        email: params.email,
        password: params.password,
      );

      return const DataSuccess(null);
    } on Failure catch (e) {
      return DataFailed(e);
    }
  }
}

class UserSignUpParams {
  final String fullName;
  final String email;
  final String password;

  UserSignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
