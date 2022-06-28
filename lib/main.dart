import 'package:flutter/material.dart';
import 'Login/splash.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'Package:firebase_core/firebase_core.dart';
import 'Package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
const SAVE_KEY_NAME = 'UserLoggedIn';
const PREF_ID = 0;
const AndroidNotificationChannel channel=AndroidNotificationChannel(
    'id',
    'name',
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();

Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

 await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
   alert: true,
   badge: true,
   sound: true
 );
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //     textTheme: GoogleFonts.poppinsTextTheme(
      //   Theme.of(context)
      //       .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
      // )),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }


  // void Notify() async {
  //   String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  //   await AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //           id: 1,
  //           title: 'Notification title',
  //           body: 'Notification body',
  //           channelKey: 'key1',
  //           bigPicture: 'https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg',
  //           notificationLayout: NotificationLayout.BigPicture
  //       ),
  //       schedule: NotificationInterval(
  //           interval: 5, timeZone: timezone, repeats: true)
  //   );
  // }
}