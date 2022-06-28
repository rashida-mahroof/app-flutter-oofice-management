// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void GetNotification()async{
//   WidgetsFlutterBinding.ensureInitialized();
//   AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'key1',
//           channelName: 'Keybot',
//           channelDescription: 'This is awesome notification ',
//           defaultColor: Color(0XFF9050DD),
//           ledColor: Colors.white,
//           playSound: true,
//           enableLights: true,
//           enableVibration: true,
//         )
//       ]
//   );
//   void Notify() async{
//     String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: 1,
//             title: 'Notification title',
//             body: 'Notification body',
//             channelKey: 'key1',
//             bigPicture: 'https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/blog/_1200x675_crop_center-center_82_line/image_optimzation.jpg',
//             notificationLayout: NotificationLayout.BigPicture
//         ),
//         schedule: NotificationInterval(interval: 5,timeZone: timezone,repeats: true)
//     );
//
//   }
// }
