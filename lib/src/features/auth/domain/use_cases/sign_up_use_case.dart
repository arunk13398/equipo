import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthUser> call(SignUpParams params) async {
    try {
      AuthUser authUser = await authRepository.signUp(
        email: params.email.value,
        password: params.password.value,
        name: params.name,
        gender: params.gender, // Pass gender parameter
      );
      return authUser;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignUpParams {
  final Email email;
  final Password password;
  final String name;
  final String gender; // Add gender parameter

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.gender, // Include gender parameter in the constructor
  });
}
