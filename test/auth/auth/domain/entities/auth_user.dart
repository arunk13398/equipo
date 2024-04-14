import 'package:equatable/equatable.dart';

// They are the business objects of the application (Enterprise-wide business rules)
// and encapsulate the most general and high-level rules.
class AuthUser extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoURL;

  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.photoURL,
  });

  static const AuthUser empty = AuthUser(
    id: '',
    name: '',
    email: '',
    photoURL: '',
  );

  // An entity can be an object with methods, or it can be a set of
  // data structures and functions.
  bool get isEmpty => this == AuthUser.empty;

  @override
  List<Object?> get props => [id, name, email, photoURL];

}
