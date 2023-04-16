import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytest/services/collectionsrefrences.dart';
import 'package:mytest/models/User/User_model.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();

    usersRef.add(
      UserModel(
          nameParameter: googleUser!.displayName!,
          imageUrlParameter: googleUser.photoUrl!,
          tokenFcm: [fcmToken!],
          idParameter: FirebaseAuth.instance.currentUser!.uid,
          createdAtParameter: DateTime.now(),
          updatedAtParameter: DateTime.now()),
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//مشان ما نعيد استخدام الفنكشن الأساسية يلي بترجع التوكين بكل فنكشن
//حطيتها ستاتسبك مشان نوصل للإلها من أيا محل بالتطبيق بدون إنشاء نسخة من الكلاس
Future<String> getFcmToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  return fcmToken!;
}
