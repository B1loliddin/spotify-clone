import 'package:spotify_clone/core/errors/failure.dart';
import 'package:spotify_clone/core/errors/server_exception.dart';
import 'package:spotify_clone/data/datasources/auth/auth_remote_data_source.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
    } on ServerException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );
    } on ServerException catch (e) {
      throw Failure(e.message);
    }
  }
}
