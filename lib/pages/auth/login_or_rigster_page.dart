import 'package:flutter/material.dart';
import 'package:mytest/pages/auth/rigster_page.dart';

import 'login_page.dart';

class LoginOrRigsterPage extends StatefulWidget {
  const LoginOrRigsterPage({super.key});

  @override
  State<LoginOrRigsterPage> createState() => _LoginOrRigsterPageState();
}

class _LoginOrRigsterPageState extends State<LoginOrRigsterPage> {
  bool showLoginPage = true;

  //

  void movePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: movePages,
      );
    } else {
      return RigsterPage(
        onTap: movePages,
      );
    }
  }
}
