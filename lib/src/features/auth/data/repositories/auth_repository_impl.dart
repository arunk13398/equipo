import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<AuthUser> get authUser {
    return remoteDataSource.user.map((authUserModel) {
      if (authUserModel != null) {
        localDataSource.write(key: 'user', value: authUserModel);
      } else {
        localDataSource.write(key: 'user', value: null);
      }

      return authUserModel == null ? AuthUser.empty : authUserModel.toEntity();
    });
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String name,
    required String gender, // Include the gender parameter here
  }) async {
    final authModel = await remoteDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      gender: gender, // Pass the gender parameter
    );

    // Save additional user data to Firestore, including the name
    await remoteDataSource.saveUserDataToFirestore(
      userId: authModel.id,
      email: email,
      name: name,
      gender: gender, // Pass the gender parameter
    );

    localDataSource.write(key: 'user', value: authModel);

    return authModel.toEntity();
  }


  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final authModel = await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    localDataSource.write(key: 'user', value: authModel);

    return authModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();

    localDataSource.write(key: 'user', value: null);
  }
}
