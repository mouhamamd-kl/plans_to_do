import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mytest/services/auth_service.dart';

import '../components/round_text_field.dart';
import '../controllers/userController.dart';
import '../models/User/User_model.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  Key key = Key("");
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    TextEditingController titleCon = TextEditingController();
    TextEditingController bodyCon = TextEditingController();
    FcmNotifications notifications = Get.put(FcmNotifications());
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              userController.updateUser(data: {
                "tokenFcm": FieldValue.arrayRemove([await getFcmToken()]),
              }, id: firebaseAuth.currentUser!.uid);
              await firebaseAuth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(
                hintText: "title",
                cursorColor: Colors.white,
                editTextBackgroundColor: Colors.white,
                iconColor: Colors.red,
                onChanged: (value) {},
                textEditingController: titleCon,
                icon: Icons.abc),
            SizedBox(
              height: 10,
            ),
            RoundedInputField(
                hintText: "body",
                cursorColor: Colors.white,
                editTextBackgroundColor: Colors.white,
                iconColor: Colors.red,
                onChanged: (value) {},
                textEditingController: bodyCon,
                icon: Icons.abc),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                UserModel model = await userController.getUserById(
                    id: firebaseAuth.currentUser!.uid);
                notifications.sendPushMessage(
                  body: bodyCon.text,
                  fcmTokens: model.tokenFcm,
                  title: titleCon.text,
                );
              },
              child: Text("send push notification"),
            ),
          ],
        ),
      )),
    );
  }
}
