import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../theme/theme.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../blocs/email_status.dart';
import '../blocs/form_status.dart';
import '../blocs/password_status.dart';
import '../blocs/sign_in/sign_in_cubit.dart';
import 'dashboard_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        signInUseCase: SignInUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  Timer? debounce;
  var size, height, width;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  void signInUser(BuildContext context) async {
    SignInState state = context.read<SignInCubit>().state;

    if (state.emailStatus == EmailStatus.valid &&
        state.passwordStatus == PasswordStatus.valid) {
      try {
        await context.read<SignInCubit>().signIn();
        String userEmail = state.email!.value; // Assuming email is not nullable

        // Check if the user is signed up (exists in Firestore)
        String userName = await getUserDisplayNameFromFirestore(userEmail);

        if (userName.isNotEmpty) {
          // Navigate to DashboardScreen with the user's name
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(userName: userName),
            ),
          );
        } else {
          // Show snackbar indicating user not signed up
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('User not signed up. Please sign up first.'),
              ),
            );
        }
      } catch (error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                  'There was an error with the sign-in process. Please try again.'),
            ),
          );
      }
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Invalid sign-in form. Please fill in all fields.'),
          ),
        );
    }
  }

  Future<String> getUserDisplayNameFromFirestore(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String displayName = querySnapshot.docs.first.get('name') ?? '';
        return displayName;
      } else {
        return '';
      }
    } catch (error) {
      print('Error retrieving user display name: $error');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser != null ? currentUser.uid : 'User not logged in';

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.submissionInProgress) {
            // You can add a loading indicator if needed
          }
          if (state.formStatus == FormStatus.invalid) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Invalid form: please fill in all fields'),
                ),
              );
          }
          if (state.formStatus == FormStatus.submissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'There was an error with the sign in process. Try again.',
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SizedBox(
                height: height / 1,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Spacer(),
                          Image(
                            image: AssetImage(
                              'assets/logo-name.png',
                            ),
                            fit: BoxFit.fill,
                            height: width / 10,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              top: 15,
                              right: 30,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Welcome back, Please enter your credentials",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, top: 30, right: 30),
                            child: TextFormField(
                              key: const Key('signIn_emailInput_textField'),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                errorText: state.emailStatus == EmailStatus.invalid
                                    ? 'Invalid email'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Colors.teal.shade50,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.teal.shade50,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade50, width: 1.2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade50, width: 1.6),
                                ),
                              ),
                              onChanged: (String value) {
                                if (debounce?.isActive ?? false) debounce?.cancel();
                                debounce = Timer(const Duration(milliseconds: 500), () {
                                  context.read<SignInCubit>().emailChanged(value);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, top: 7, right: 30),
                            child: TextFormField(
                              key: const Key('signIn_passwordInput_textField'),
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                errorText: state.passwordStatus == PasswordStatus.invalid
                                    ? 'Invalid password'
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Colors.blue.shade50,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.teal.shade50,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade50, width: 1.2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade50, width: 1.6),
                                ),
                              ),
                              onChanged: (String value) {
                                context.read<SignInCubit>().passwordChanged(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 10, right: 10),
                            child: SizedBox(
                              width: width / 2.5,
                              height: 43,
                              child: MaterialButton(
                                  key: const Key('signIn_continue_elevatedButton'),
                                  onPressed: state.formStatus == FormStatus.submissionInProgress
                                      ? null
                                      : () {
                                    signInUser(context); // Call signInUser method
                                  },
                                  textColor: Colors.white,
                                  color: MyColors.constantColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0)),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 10, right: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Does't have an account?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " Signup",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors.constantColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                          Spacer(),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
