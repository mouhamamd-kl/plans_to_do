import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytest/models/User/User_model.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/sqaure_Button.dart';
import '../../controllers/userController.dart';
import '../../services/auth_service.dart';

class RigsterPage extends StatefulWidget {
  RigsterPage({super.key, required this.onTap});

  Function()? onTap;

  @override
  State<RigsterPage> createState() => _RigsterPageState();
}

class _RigsterPageState extends State<RigsterPage> {
  final userEmailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  UserController userController = Get.put(UserController());

  void signUpUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (confirmPasswordController.text == passwordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: userEmailController.text,
                password: passwordController.text)
            .then((value) async {
          String token = await getFcmToken();
          UserModel userModel = UserModel(
              nameParameter: "sung jin woo",
              imageUrlParameter:
                  "https://i.pinimg.com/originals/7e/29/17/7e29176ed998ad8d35cd1813dee93a7f.jpg",
              tokenFcm: [token],
              idParameter: value.user!.uid,
              createdAtParameter: DateTime.now(),
              updatedAtParameter: DateTime.now());
          await userController.createUser(userModel: userModel);
          return value;
        });
      } else {
        errorMessage('password and confirm password not the same');
      }
      Get.back();
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);

      if (ex.code == 'user-not-found') {
        errorMessage('Wrong Email');
      }

      if (ex.code == 'wrong-password') {
        errorMessage('Wrong password');
      } else {
        errorMessage(ex.code);
      }
    }
  }

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              '$message ❌',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // logo App
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: 250,
                    child: Image.asset('lib/images/logo.png'),
                  ),
                ),

                //say Hi
                Text(
                  'Nice to see You!',
                  style: GoogleFonts.pacifico(fontSize: 30),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Email field
                myTextFiled(
                  isDense: true,
                  obscureText: false,
                  controller: userEmailController,
                  hinText: 'Email',
                  inputType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                // password field

                myTextFiled(
                  isDense: true,
                  obscureText: true,
                  controller: passwordController,
                  hinText: 'Password',
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.deepPurpleAccent,
                  ),
                ),

                myTextFiled(
                  isDense: true,
                  obscureText: true,
                  controller: confirmPasswordController,
                  hinText: 'Confirm Password',
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.deepPurpleAccent,
                  ),
                ),

                //forget Password

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),
                //Login button

                MyButton(
                  onTap: signUpUser,
                  buttonText: 'Sign Up',
                  color: Colors.deepPurpleAccent,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or Continue With'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                // Google icon Sign in
                SquareButtonIcon(
                    imagePath: 'lib/images/google.png',
                    onTap: () {
                      AuthService().signInWithGoogle();
                    }),
                const SizedBox(
                  height: 10,
                ),
                // not registered make am account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login Now!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
