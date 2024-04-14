import 'package:equipo/src/features/auth/presentation/screens/dashboard_screen.dart';
import 'package:equipo/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:equipo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.constantColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/logo.png'),
                color: Colors.white,
                height: 70.0,
                width: 70.0,
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(color: Colors.teal.shade100),
          ],
        ),
      ),
    );
  }

  void checkLogin() async {
    // Delay for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is signed in
    if (FirebaseAuth.instance.currentUser != null) {
      // User is signed in, navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(userName: FirebaseAuth.instance.currentUser!.displayName ?? "")),
      );
    } else {
      // User is not signed in, navigate to the sign-in screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }
}
