abstract interface class AuthRepository {
  const AuthRepository();

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });
}
