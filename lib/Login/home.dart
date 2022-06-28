import 'dart:convert';
import 'dart:io' as io;
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/Approval/Approval.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Attendance/attendance.dart';
import 'package:untitled/Employee/Employee.dart';
import 'package:untitled/Followup/followup-list.dart';
import 'package:untitled/Incentive/summary.dart';
import 'package:untitled/Information/Info_main.dart';
import 'package:untitled/Login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:untitled/Prospectus/Prospect-list.dart';
import 'package:untitled/Reminder/Reminder.dart';
import 'package:untitled/Sales/SalesOrder.dart';
import 'package:untitled/Scan/Scan.dart';
import 'package:untitled/Task/Taskdetailview.dart';
import 'package:untitled/Task/Taskview.dart';
import '../Approval/Approval_Details.dart';
import '../Logistics/trips-list.dart';
import '../Model/users.dart';
import '../Notifications/fcm_notofocation_service.dart';
import 'Package:firebase_core/firebase_core.dart';
import 'Package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class screenHome extends StatefulWidget {
  var id = globals.login_id;
  var Obj;
  screenHome({this.Obj});

  @override
  _screenHomeState createState() => new _screenHomeState();
}

Color activeColor = Colors.orange.shade700;
final controller = CropController(
  aspectRatio: 1,
  defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
);
late final FirebaseMessaging _fcm ;
class _screenHomeState extends State<screenHome> {
  int _counter=0;
  @override
  void initState() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification? notification = message.notification;
      showNotification();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {     print("onBackgroundMessage: $message");   });

    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.orange,
                  playSound: true,
                  icon: '@mipmap/keybot'

              ),
            )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('new message');
      RemoteNotification? notification=message.notification;
      AndroidNotification? android=message.notification?.android;
      if(notification!=null&&android!=null)
      {
        showDialog(context: context
            , builder: (_)
        {
          return AlertDialog(
            title: Text(notification.title as String),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(notification.body as String)
                ],
              ),
            ),
          );
        });
      }
    });
  }
  void showNotification(){
    setState((){
      _counter++;});
    flutterLocalNotificationsPlugin.show(0,
        "title$_counter", "body",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                importance: Importance.high,
                color: Colors.orange,
                playSound: true,
                icon: '@mimap/keybot'
            )
        )
    );
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  String Subject(dynamic user) {
    return user['Subject'];
  }

  String Type(dynamic user) {
    return user['Type'];
  }

  String Date(dynamic user) {
    return user['Date'];
  }

  String Time(dynamic user) {
    return user['Time'];
  }

  String Userr(dynamic user) {
    return user['User'];
  }
  String ID(dynamic user) {
    return user['ID'];
  }

  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  User user = User();
  bool _customTileExpanded = false;
  final _cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = widget.Obj['Email'].toString();
    var mobile = widget.Obj['Mobile'].toString();
    var modi = widget.Obj['ModifiedDate'].toString();
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    int l = modi.length;
    if (modi == 'null') {
      l = 0;
    }
    Iterable<dynamic> contain = [];
    Iterable<dynamic> contain1 = [];
    Iterable<dynamic> contain2 = [];
    Iterable<dynamic> contain3 = [];
    Iterable<dynamic> contain4 = [];
    Iterable<dynamic> contain5 = [];
    Iterable<dynamic> contain6 = [];
    Iterable<dynamic> contain7 = [];
    Iterable<dynamic> contain8 = [];
    Iterable<dynamic> contain9 = [];
    Iterable<dynamic> contain10 = [];
    Iterable<dynamic> contain11 = [];
    if (widget.Obj['Right'].toString() != null) {
      contain = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Attendance');
      contain1 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Information');
      contain2 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Reminder');
      contain3 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Approval');
      contain4 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Task');
      contain5 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Members');
      contain6 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Scan');
      contain7 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Sales');
      contain8 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Incentive');
      contain9 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Prospect');
      contain10 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Followup');
      contain11 = widget.Obj['Right']
          .where((element) => element['WindowName'] == 'Logistic');
    }
    var imgurl = "https://www.hokybo.com/assets/Users/" +
        globals.login_id.toString() +
        ".jpg?" +
        modi;
    globals.name=widget.Obj['Name'].toString()+'('+widget.Obj['UserName'].toString()+')';

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              SizedBox(
                // height: height / 3.7,
                height: 230,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.2,
                          0.8,
                        ],
                        colors: [
                          Colors.orange,
                          Colors.red,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text(widget.Obj.toString()),
                        //XFile? image = await picker.pickImage(source: ImageSource.gallery);

                        SizedBox(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreenImage(imageUrl: imgurl)));
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: l > 0
                                      ? NetworkImage(imgurl)
                                      : AssetImage(
                                              'assets/img/default-user-imge.jpeg')
                                          as ImageProvider,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Positioned(
                                  right: -8,
                                  bottom: -8,
                                  child: IconButton(
                                    onPressed: () {
                                      getImagebyGallery(context);
                                    },
                                    icon: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                        child: const Icon(
                                          Icons.add_a_photo,
                                          size: 22,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        //Text(widget.Obj['UserID'].toString()),
                        Text(
                          widget.Obj['Name'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          widget.Obj['Role'].toString(),
                          style: TextStyle(
                              color: Colors.grey.shade300, fontSize: 11),
                        ),
                      ],
                    )),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Row(
                        children: [
                          Text('Profile'),
                        ],
                      ),
                      //subtitle: Text('Trailing expansion arrow icon'),
                      children: [
                        ListTile(
                            title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Member Code',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 192, 192, 192),
                                  fontSize: 12),
                            ),
                            Text(
                              widget.Obj['UserName'].toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 110, 110, 110)),
                            ),
                          ],
                        )),
                        ListTile(
                            title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 192, 192, 192),
                                  fontSize: 12),
                            ),
                            Flexible(
                              child: Text(
                                email,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 110, 110, 110)),
                              ),
                            ),
                          ],
                        )),
                        ListTile(
                            title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mobile',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 182, 181, 181),
                                  fontSize: 12),
                            ),
                            Text(
                              mobile,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 110, 110, 110)),
                            ),
                          ],
                        )),
                        // ListTile(
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(''),
                        //       InkWell(
                        //           onTap: () async {
                        //             var imageExist =
                        //                 "https://www.hokybo.com/assets/Users/" +
                        //                     globals.login_id.toString() +
                        //                     ".jpg";
                        //             emailController.text = widget.Obj['Email'];
                        //             mobileController.text =
                        //                 widget.Obj['Mobile'];
                        //             showModalBottomSheet(
                        //               shape: const RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.vertical(
                        //                       top: Radius.circular(12))),
                        //               isScrollControlled: true,
                        //               context: context,
                        //               builder: (BuildContext context) {
                        //                 return Padding(
                        //                   padding: EdgeInsets.only(
                        //                       bottom: MediaQuery.of(context)
                        //                           .viewInsets
                        //                           .bottom),
                        //                   child: Form(
                        //                     key: _formkey,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                               vertical: 20,
                        //                               horizontal: 15),
                        //                       child: Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.center,
                        //                         mainAxisSize: MainAxisSize.min,
                        //                         children: [
                        //                           // CircleAvatar(
                        //                           //                                      backgroundImage:
                        //                           //     AssetImage('assets/img/user.jpg'),
                        //                           // backgroundColor: Colors.transparent,
                        //                           // backgroundColor:
                        //                           //     Colors.blue,
                        //                           //   radius: 50,
                        //
                        //                           //    child: Image.file(io.File(imageFile.path),fit: BoxFit.cover,)
                        //
                        //                           // child: Icon(Icons.add_a_photo),
                        //                           // ),
                        //
                        //                           TextFormField(
                        //                             autofocus: true,
                        //                             validator: (value) {
                        //                               final bool isValid =
                        //                                   EmailValidator
                        //                                       .validate(value!);
                        //                               if (value == null ||
                        //                                   value.isEmpty) {
                        //                                 return 'Value is Empty';
                        //                               }
                        //                               // else if (isValid ==
                        //                               //     false) {
                        //                               //   return 'Invalid Email Address';
                        //                               // }
                        //                               else {
                        //                                 return null;
                        //                               }
                        //                             },
                        //                             controller: emailController,
                        //                             decoration: InputDecoration(
                        //                                 labelText: 'Email'),
                        //                             // initialValue:widget.Obj['Email'],
                        //                           ),
                        //                           SizedBox(
                        //                             height: 10,
                        //                           ),
                        //                           TextFormField(
                        //                               decoration:
                        //                                   InputDecoration(
                        //                                       labelText:
                        //                                           'Mobile'),
                        //                               controller:
                        //                                   mobileController,
                        //                               style: TextStyle(),
                        //                               validator: (value) {
                        //                                 const pattern =
                        //                                     r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                        //                                 final regExp =
                        //                                     RegExp(pattern);
                        //                                 if (value == null ||
                        //                                     value.isEmpty) {
                        //                                   return 'Value is Empty';
                        //                                 } else if (!regExp
                        //                                         .hasMatch(
                        //                                             value) ||
                        //                                     value.length < 10 ||
                        //                                     value.length > 10) {
                        //                                   return 'Invalid Mobile Number';
                        //                                 } else {
                        //                                   return null;
                        //                                 }
                        //                               }),
                        //                           SizedBox(
                        //                             height: 20,
                        //                           ),
                        //                           ElevatedButton(
                        //                               style: ElevatedButton
                        //                                   .styleFrom(
                        //                                       primary: Colors
                        //                                           .orange
                        //                                           .shade700),
                        //                               child:
                        //                                   const Text('Update'),
                        //                               onPressed: () async {
                        //                                 if (_formkey
                        //                                     .currentState!
                        //                                     .validate()) {
                        //                                   update(context);
                        //                                   setState(() {
                        //                                     // email =
                        //                                     //     emailController
                        //                                     //         .text;
                        //                                     // mobile =
                        //                                     //     mobileController
                        //                                     //         .text;
                        //                                     // redirecttohome(context);
                        //                                   });
                        //                                 }
                        //                                 // var response2 = await http.post(
                        //                                 //     Uri.parse(
                        //                                 //         'https://www.hokybo.com/tms/api/User/postUpdateUser?p=1&q=2&r=3'),
                        //                                 //     headers: {
                        //                                 //       "Content-Type":
                        //                                 //           "application/x-www-form-urlencoded",
                        //                                 //     },
                        //                                 //     encoding: Encoding
                        //                                 //         .getByName(
                        //                                 //             'utf-8'),
                        //                                 //     body: ({
                        //                                 //       "UserID": widget
                        //                                 //           .Obj[
                        //                                 //               'UserID']
                        //                                 //           .toString(),
                        //                                 //       "Email":
                        //                                 //           emailController
                        //                                 //               .text,
                        //                                 //       "Mobile":
                        //                                 //           mobileController
                        //                                 //               .text
                        //                                 //     }));
                        //                                 // if (response2
                        //                                 //         .statusCode ==
                        //                                 //     200) {
                        //                                 //   print(
                        //                                 //       response2.body);
                        //                                 //   var json1 =
                        //                                 //       jsonDecode(
                        //                                 //           response2
                        //                                 //               .body);
                        //                                 //   user =
                        //                                 //       User.fromJson(
                        //                                 //           json1);
                        //                                 // }
                        //                                 //   Navigator.pop(context);
                        //                               })
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //             );
                        //             //Navigator.of(context, rootNavigator: true).pop();
                        //           },
                        //           child: Text(
                        //             'Edit Profile',
                        //             style: TextStyle(
                        //                 color: Colors.blue, fontSize: 10),
                        //           )),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('About'),
                      // collapsedIconColor: Colors.orange.shade700,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Text(
                            'KEYBOT is a simple and user-friendly business  management solution offered by Home Key Ventures, Pvt. Ltd from Tip Top Group. It is a free to-do list, approvals receiving, announcements, prospect handling, QR/barcode scanner, attendance tracking, task management, sales report and reminder application that will help you work in an organised and effective manner throughout the day. KEYBOT can assist you regardless of who you are or what you do!. For more information about KEYBOT, visit - www.hokybo.com .',
                            style: GoogleFonts.poppins(
                                color: Colors.black87, fontSize: 12),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                    ListTile(
                      title: Text('Logout'),
                      onTap: () {
                        signout(context);
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Container(
                      padding:  EdgeInsets.only(top: height / 2.4 ),
                      child: Text('Version:202.206.10',style: TextStyle(fontSize: 12,color: Colors.black45),)
                  )),
            ],
          ),
        ),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // color: Colors.blue
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.2,
                  0.8,
                ],
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
              ),
            ),
          ),
// actions: [
//   IconButton(onPressed: (){
//    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageImgdwld()));
//     // Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImage(image: )));
//   }, icon: Icon(Icons.add))
// ],
          toolbarHeight: 90,
          // backgroundColor: Colors.orange.shade700,
          title: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Container(
              width: width / 3.1,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white)),
              child: Image.asset(
                'assets/img/keybot.png',
                width: width / 3,
                height: 90,
              ),
            ),
          ),
          
        ),
        body: SlidingUpPanel(
          parallaxEnabled: true,
          parallaxOffset: .5,
          minHeight: 50,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
          panel: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    if (contain3.toString() !=
                                        '()') //if for approval widget
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Information(search: "null",)));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            //color: Colors.white38.withOpacity(0.2),
                                            // color: Colors.teal.shade700,
                                            // boxShadow: [
                                            //   new BoxShadow(
                                            //     color: Color.fromARGB(
                                            //         255, 173, 194, 211),
                                            //     blurRadius: 8.0,
                                            //   ),
                                            // ]
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.teal,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(
                                                    Icons.approval_sharp,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Approvals',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain4.toString() !=
                                        '()') //if for task widget
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Task()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.red.shade600,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade600,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(
                                                      Icons.task_rounded,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Tasks',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain1.toString() != '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InformationView()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.orangeAccent,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.orange.shade700,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(Icons.info,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Information',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain6.toString() != '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScanApp()));
                                        }),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          decoration: BoxDecoration(
                                            // color: Colors.indigo,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade600,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(Icons.qr_code,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Scan',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain7.toString() !=
                                        '()') //if for sales widget
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SalesOrderView()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.lightGreen.shade800,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .lightGreen.shade600,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(
                                                      Icons.point_of_sale,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Sales',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain8.toString() != '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SummaryView()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.purple.shade800,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.purple.shade800,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(
                                                      Icons.currency_rupee,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Incentive',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain9.toString() != '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                   ProspectsList()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.brown.shade800,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  color: Colors.pink.shade500,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(
                                                      Icons.speaker_notes,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Prospectus',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain10.toString() != '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                   FollowupList()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.brown.shade800,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade900,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Icon(Icons.wechat,
                                                      color: Colors.white,
                                                      size: 35),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Follow up',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (contain11.toString() !=
                                        '()')
                                      InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const TripsList()));
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.brown.shade800,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          height: 120,
                                          width: width / 4,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.brown.shade800,
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color:
                                                      Colors.grey.shade400),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                  //     spreadRadius: 3,
                                                  //     blurRadius: 10,
                                                  //     offset: Offset(0, 1), // changes position of shadow
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(15),
                                                  child: Icon(Icons.local_shipping,color: Colors.white,size: 35,)
                                                ),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'Logistic',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, bottom: 30, left: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ' + ' ' + widget.Obj['Name'].toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.teal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                new Divider(),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 70),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (contain.toString() != '()')
                              //attendance
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const attendanceDetails()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.teal.shade50,
                                              // border: Border.all(color: Colors.teal.shade100),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: [
                                                new BoxShadow(
                                                    color: Color(0xFFE2E2E2),
                                                    blurRadius: 8.0)
                                              ]),
                                          child: Icon(
                                            Icons.calendar_today_rounded,
                                            color: Color(0xFF2A6F4E),
                                            size: 30,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'Attendance',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            if (contain5.toString() != '()')
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EmployeeView()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.orange.shade50,
                                              // border: Border.all(color: Colors.orange.shade100),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: [
                                                new BoxShadow(
                                                    color: Color(0xFFDCDCDC),
                                                    blurRadius: 8.0)
                                              ]),
                                          child: Icon(
                                            Icons.account_circle,
                                            color: Color(0xFFE76E02),
                                            size: 35,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'Members',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            if (contain2.toString() != '()') //members
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReminderList()));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, left: 3),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              // border: Border.all(color: Colors.blue.shade100)
                                              boxShadow: [
                                                new BoxShadow(
                                                    color: Color(0xFFD7D7D7),
                                                    blurRadius: 8.0)
                                              ]),
                                          child: Icon(
                                            Icons.notifications_on,
                                            color: Colors.blue,
                                            size: 35,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'Reminder',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                'Notifications',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(right: 10, bottom: 10),
                                height: height / 2.5,
                                decoration: BoxDecoration(
                                    color: Colors.indigo.shade50,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      new BoxShadow(
                                        color:
                                            Color.fromARGB(255, 217, 210, 248),
                                        blurRadius: 8.0,
                                      ),
                                    ]),
                                child: FutureBuilder<List<dynamic>>(
                                  future: fetchnotif(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          // padding: const EdgeInsets.all(8),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                             return GestureDetector(
                                              onTap: ()async {
                                                if(Type(snapshot.data[index])=='Approval'){
                                                  getItemAndNavigate(int.parse(ID(snapshot.data[index])),context);
                                                } //Approval

                                                if(Type(snapshot.data[index])=='Task'){
                                                  getItemAndNavigateTask(int.parse(ID(snapshot.data[index])),context);
                                                }
                                                
                  
                                                // if(1==2) //information
                                                //   Navigator.push(
                                                //       context,
                                                //       MaterialPageRoute(
                                                //           builder: (context) =>
                                                //            InfoDetailsById(InfoID: 1, type: 1, count: 1,)));
                                                // if(1==2) //Task
                                                //   Navigator.push(
                                                //       context,
                                                //       MaterialPageRoute(
                                                //           builder: (context) =>
                                                //            Taskdetail(Obj: [],)));
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      Subject(
                                                          snapshot.data[index]),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 13),
                                                    ),
                                                    subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          Type(snapshot.data[
                                                                  index]) +
                                                              ' From ',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                        Text( Userr(snapshot
                                                            .data[index]),maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontWeight: FontWeight.w500,
                                                              fontSize: 11,
                                                              color: Colors
                                                                  .black54),)
                                                      ],
                                                    ),
                                                    trailing: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 34),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            Time(snapshot.data[
                                                                    index]) +
                                                                ', ' +
                                                                Date(snapshot
                                                                        .data[
                                                                    index]),
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black45),
                                                          ),
                                                          // Text(
                                                          //   ,
                                                          //   maxLines: 1,
                                                          //   style: TextStyle(
                                                          //       fontSize: 11,
                                                          //       color: Colors
                                                          //           .black54),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    selectedTileColor:
                                                        Colors.green,
                                                  ),
                                                  new Divider(),
                                                ],
                                              ),
                                              // Column(
                                              //   children: [
                                              //     Container(
                                              //       height: 50,
                                              //       child: Column(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment.start,
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment.start,
                                              //         children: [
                                              //           Row(
                                              //             children: [
                                              //               Text(
                                              //                 'lo0rem ipsem subjewct lo0rem ipsem subjewct',
                                              //                 maxLines: 1,
                                              //                 overflow: TextOverflow
                                              //                     .ellipsis,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     const Divider(
                                              //       color: Colors.black26,
                                              //     ),
                                              //   ],
                                              // ),
                                            );
                                          });
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear;
    // var  _id = _sharedPrefs.getInt('PREF_ID');
    await _sharedPrefs.setInt('PREF_ID', 0);
    var _id = _sharedPrefs.getInt('PREF_ID');

    globals.login_id = 0;
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const ScreenLogin()),
        (route) => false);
  }

  late io.File imageFile = io.File('assets/img/User-Icon-PNG.png');
  ImagePicker _picker = ImagePicker();
  getImagebyGallery(BuildContext contxt) async {
    PickedFile? pick =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 40);

    if (pick != null) {
      setState(() {
        imageFile = io.File(pick.path);
      });

      updateimg(contxt);
    }
  }

  update(BuildContext context) async {
    var Posturi =
        Uri.parse('https://www.hokybo.com/tms/api/User/postUpdateUser');
    var request = http.MultipartRequest("POST", Posturi);
    request.fields['UserID'] = globals.login_id.toString();
    request.fields['Email'] = emailController.text;
    request.fields['Mobile'] = mobileController.text;
    final sends = await request.send();
    var response = await sends.stream.bytesToString();
    request.send().then((response) {
      Fluttertoast.showToast(
          msg: 'Profile Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      if (response.statusCode == 200) {
        print(response);
      }
    });
    redirecttohome(context);
  }

  updateimg(BuildContext context) async {
    var Posturi =
        Uri.parse('https://www.hokybo.com/tms/api/User/postUpdateUserImage');
    var request = http.MultipartRequest("POST", Posturi);
    request.fields['UserID'] = globals.login_id.toString();
    if (imageFile.path != 'assets/img/User-Icon-PNG.png') {
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      request.files.add(await http.MultipartFile('File', stream, length,
          filename: path.basename(imageFile.path)));
    }
    final sends = await request.send();
    var response = await sends.stream.bytesToString();
    request.send().then((response) {
      Fluttertoast.showToast(
          msg: 'Profile Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      if (response.statusCode == 200) {
        print(response);
      }
    });
    redirecttohome(context);
  }

  redirecttohome(BuildContext context) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    var _id = _sharedPrefs.getInt('PREF_ID');
    globals.login_id = _id!;
    User user = User();
    var url = Uri.parse(
        'https://www.hokybo.com/tms/api/User/GetUserByID?UserID=' +
            _id.toString());
    final response = await http.get(url);
    var json1 = jsonDecode(response.body);
    print(json1);
    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }

  Future<List<dynamic>> fetchnotif() async {
    final String apiUrl =
        'https://www.hokybo.com/tms/api/Notifications/GetNotifications?UserId=' +
            globals.login_id.toString();
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }


  getItemAndNavigate(int index, BuildContext context) async {
    var detaildata;
    var response2 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/Approval/GetAllDetailsByID?ApprId=" +
            index.toString()+'&UserId='+globals.login_id.toString()));
    if (response2.statusCode == 200) {
      detaildata = json.decode(response2.body)['data'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) => Detailshow(Obj: detaildata)));
    }
  }

  // getItemAndNavigateTask(int index, BuildContext context) async {
  //   var response2 = await http.get(Uri.parse(
  //       "https://www.hokybo.com/tms/api/Task/GetAllDetailsByID?ApprId=" +
  //           index.toString()+"&UserID="+globals.login_id.toString()));
  //   if (response2.statusCode == 200) {
  //     var detaildata = json.decode(response2.body)['data'];
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context1) => Taskdetail(Obj: detaildata)));
  //   }
  // }
  //
  var detaildata;
  List<dynamic>detaildata4=[];
  getItemAndNavigateTask(int index, BuildContext context) async {
    var response2 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/Task/GetAllDetailsByID?ApprId=" +
            index.toString()+"&UserID="+globals.login_id.toString()));
    if (response2.statusCode == 200) {
      detaildata = json.decode(response2.body)['data'];

      var response3 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/TaskUpd/GetTransmissionDetaiils?TaskID=" +
            index.toString()));
            if(response3.statusCode == 200)
            {
              detaildata4 = json.decode(response3.body);
               Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) => Taskdetail(Obj: detaildata,Transmission:detaildata4,)));
            }
     
    }
  }
}
