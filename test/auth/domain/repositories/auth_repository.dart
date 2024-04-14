import '../entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser> get authUser;

  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String name, required String gender, // Add the name parameter here
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
