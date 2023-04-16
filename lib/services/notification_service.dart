import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mytest/controllers/userController.dart';
import 'package:mytest/models/User/User_model.dart';

import '../constants/constants.dart';
import '../main.dart';
import 'auth_service.dart';

class FcmNotifications extends GetxService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    requestPermission();
    initInfo();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional');
    } else {
      print('user declined permission');
    }
  }

  String constructFCMPayload({
    required List<String> fcmTokens,
    required String type,
    Map<String, dynamic>? data,
    required String title,
    required String body,
  }) {
    Map<String, dynamic> insidedata = <String, dynamic>{};
    insidedata.addAll({
      'type': type,
    });

    return jsonEncode({
      "registration_ids": fcmTokens,
      "notification": {
        "title": title,
        "body": body,
        "android_channel_id": "dbfood",
      },
      "data": insidedata
    });
  }

  Future<void> sendPushMessage({
    required List<String> fcmTokens,
    required String title,
    required String body,
  }) async {
    UserModel model =
        await userController.getUserById(id: firebaseAuth.currentUser!.uid);
    if (fcmTokens.isEmpty || title.isEmpty || body.isEmpty) {
      print(
          'Unable to send FCM message, check if one of the following is empty fcmTokens,title,body.');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKeyK',
        },
        body: constructFCMPayload(
          body: body,
          fcmTokens: model.tokenFcm,
          title: title,
          type: "notification",
        ),
      );
      if (response.statusCode == 200) {
        print('FCM notification sent successfully.');
      } else {
        print(
            'Failed to send FCM notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void initInfo() async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        Map<String, dynamic> data = jsonDecode(response.payload!);
        print(data);
      },
    );
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(handleMessage);
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      handleMessage(remoteMessage);
    }
  }

  Future<void> handleMessage(RemoteMessage message) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      //channel id
      'dbfood',
      //channel name
      'dbfood',
      //channel description
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: false,
      //if we want to add custom sound we just add it in the
      //  `res/raw` directory of the Android application
      //sound: RawResourceAndroidNotificationSound('_sound'),
    );

    NotificationDetails platformChannelSpecific = NotificationDetails(
      android: androidNotificationDetails,
    );
    print(message.data.toString());
    showNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      platformChannelSpecific: platformChannelSpecific,
      payload: jsonEncode(message.data),
    );
  }

  showNotification({
    required String title,
    required String body,
    required NotificationDetails platformChannelSpecific,
    required String payload,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecific,
      payload: payload,
    );
  }
}
