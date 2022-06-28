import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void sendNotification(
  String? title,
  String? body,
) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/keybot');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high channer', 'High Importance Notification',
      description: "this channel is for important notification",
      importance: Importance.max);
  // var sheduledtime = DateTime.now();
  //
  // tz.initializeTimeZones();
  // await flutterLocalNotificationsPlugin.zonedSchedule(
  //     12345,
  //     "A Notification From My App",
  //     "This notification is brought to you by Local Notifcations Package",
  //     tz.TZDateTime.now(tz.local).add(const Duration(days: 3)),
  //     const NotificationDetails(
  //         android: AndroidNotificationDetails('hi', 'CHANNEL_DESCRIPTION')),
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime);

  flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description)));
}
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// void sendNotification(String? title, String? body) async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/keybot');
//   const IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true);
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high channer', 'High Importance Notification',
//       description: "this channel is for important notification",
//       importance: Importance.max);
//   tz.initializeTimeZones();
//   var androidPlatformChannelSpecifics;
//   var iOSPlatformChannelSpecifics;
//   var linuxPlatformChannelSpecifics;
//   var macOSPlatformChannelSpecifics;
//   final NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//     iOS: iOSPlatformChannelSpecifics,
//     macOS: macOSPlatformChannelSpecifics,
//     linux: linuxPlatformChannelSpecifics,
//   );
//   flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime);
//  }
