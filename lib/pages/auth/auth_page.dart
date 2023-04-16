import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'login_or_rigster_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user Logged in
          if (snapshot.hasData) {
            return NotificationScreen();
          } else {
            return const LoginOrRigsterPage();
          }

          // user not Logged in
        },
      ),
    );
  }
}
