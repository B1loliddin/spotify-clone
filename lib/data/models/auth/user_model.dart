import 'package:spotify_clone/domain/entities/auth/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.fullName,
    super.email,
    super.password,
  });

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'password': password,
    };
  }
}
