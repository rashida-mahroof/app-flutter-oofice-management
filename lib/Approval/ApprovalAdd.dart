import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:badges/badges.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import'../Notifications/fcm_notofocation_service.dart';
import 'Approval.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _formKey = GlobalKey<FormState>();
late List<String>? DeptList = [];

class Addnew extends StatefulWidget {
  const Addnew({Key? key}) : super(key: key);
  @override
  State<Addnew> createState() => _AddnewcreateState();
}

class _AddnewcreateState extends State<Addnew> {
  bool isEnabled = true;
  bool _showBadgelow = false;
  bool _showBadgemedium = true;
  bool _showBadgeurgent = false;
  Color activesliderColor = Colors.orange;
  String color = 'YELLOW';
  bool _isPressed = false;
  String btnTxt = 'ASK APPROVAL';

  get name => null;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final TextEditingController _textController = TextEditingController();
  final CollectionReference _tokensDB =
  FirebaseFirestore.instance.collection('Tokens');
  final FCMNotificationService _fcmNotificationService =
  FCMNotificationService();

  String _otherDeviceToken="";
  @override
  void initState() {
    super.initState();

    load(selectedCity).whenComplete((){
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    IntiaGetDepts();
    IntiaGetRoles('All');
    GetUsers('All', 'All');
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        toolbarHeight: 70,
        title: const Text("Create Approval"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () {
                  redirectHome(context);
                },
                icon: Icon(
                  Icons.home,
                  size: 25,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Center(
          child: Column(
            children: [
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //if(DeptList!.length>1)
                          ShowDept(),
                          //if(RoleList!.length>1)
                          ShowSingle(),
                          //if(UserList!.length>1)
                          ShowGroup(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Subject",
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black54),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                ),
                                prefixIcon: Icon(
                                  Icons.sticky_note_2,
                                  color: Colors.orange,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Subject is required';
                                } else {
                                  return null;
                                }
                              },
                              controller: subject,
                              maxLines: null,
                              maxLength: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.notes,
                                    color: Colors.orange,
                                  ),
                                  labelText: "Content",
                                  labelStyle: GoogleFonts.poppins(
                                      color: Colors.black54),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2),
                                  ),
                                  border: OutlineInputBorder()),
                              controller: content,
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange.shade100)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              'Set Preference :   ',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                color = "GREEN";
                                                _showBadgelow = true;
                                                _showBadgemedium = false;
                                                _showBadgeurgent = false;
                                              });
                                            },
                                            child: Badge(
                                              badgeColor: Colors.green.shade100,
                                              showBadge: _showBadgelow,
                                              animationDuration:
                                                  Duration(milliseconds: 300),
                                              animationType:
                                                  BadgeAnimationType.slide,
                                              badgeContent: Icon(
                                                Icons.done,
                                                size: 11,
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.green.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 18),
                                                    child: Row(
                                                      children: [
                                                        // Icon(Icons.low_priority,color: Colors.green,size: 15,),
                                                        Text(
                                                          'Low',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _showBadgemedium = true;

                                                _showBadgelow = false;
                                                color = "YELLOW";
                                                _showBadgeurgent = false;
                                              });
                                            },
                                            child: Badge(
                                              badgeColor:
                                                  Colors.orange.shade100,
                                              showBadge: _showBadgemedium,
                                              animationDuration:
                                                  Duration(milliseconds: 300),
                                              animationType:
                                                  BadgeAnimationType.slide,
                                              badgeContent: Icon(
                                                Icons.done,
                                                size: 11,
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.orange.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 18),
                                                    child: Row(
                                                      children: [
                                                        // Icon(Icons.warning_amber_outlined,color: Colors.orange,size: 15,),
                                                        Text(
                                                          'Medium',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                color = "RED";
                                                _showBadgeurgent = true;
                                                _showBadgelow = false;
                                                _showBadgemedium = false;
                                              });
                                            },
                                            child: Badge(
                                              badgeColor: Colors.red.shade100,
                                              showBadge: _showBadgeurgent,
                                              animationDuration:
                                                  Duration(milliseconds: 300),
                                              animationType:
                                                  BadgeAnimationType.slide,
                                              badgeContent: Icon(
                                                Icons.done,
                                                size: 11,
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 3,
                                                        horizontal: 18),
                                                    child: Row(
                                                      children: [
                                                        // Icon(Icons.priority_high,color: Colors.red,size: 15,),
                                                        Text(
                                                          'Urgent',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor:
                                        Color.fromARGB(255, 49, 49, 49),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 30),
                                        child: Container(
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  FloatingActionButton(
                                                    onPressed: () {
                                                      getImagebyCamera();
                                                      Navigator.pop(context);
                                                    },
                                                    tooltip:
                                                        "Pick Image form Camera",
                                                    child: const Icon(
                                                        Icons.add_a_photo),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  FloatingActionButton(
                                                    backgroundColor:Colors.pink,
                                                    onPressed: () {
                                                      getImagebyGallery();
                                                      Navigator.pop(context);
                                                    },
                                                    tooltip:
                                                        "Pick Image form Gallery",
                                                    child: const Icon(
                                                        Icons.camera),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  FloatingActionButton(
                                      backgroundColor:Colors.purple,
                                                    onPressed: () {
                                                      _pickDocFile();
                                                      Navigator.pop(context);
                                                    },
                                                    tooltip:
                                                    "Pick Document",
                                                    child: const Icon(
                                                        Icons.note_add),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    'Document',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.teal,
                              ),
                              label: Text(
                                'Add File',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w500),
                              )),
                          Row(
                            children: [
                              Expanded(child: PreviewImg()),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isPressed == false
                          ? () => _myCallback(context)
                          : null,
                      style:
                          ElevatedButton.styleFrom(primary: Colors.deepOrange),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: (1 == 1)
                            ? Text(
                                btnTxt,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> load(String nam) async {

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    //Validate that it's not null.
    assert(token != null);

    //Determine what device we are on.
     String thisDevice;
    String otherDevice;


      thisDevice = globals.name;
      otherDevice = nam.toString();
    DocumentReference docRef = _tokensDB.doc(thisDevice);
    docRef.set({'token': token});

    //Fetch the fcm token for the other device.
    DocumentSnapshot docSnapshot = await _tokensDB.doc(otherDevice).get();
    _otherDeviceToken = docSnapshot['token'];

  }

  Future _myCallback(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isPressed = true;
        btnTxt = 'SENDING...';
      });
      var Posturi =
          Uri.parse('https://www.hokybo.com/tms/api/Approval/PostCreate');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Subject'] = subject.text;
      request.fields['Message'] = content.text;
      request.fields['UserID'] = globals.login_id.toString();
      request.fields['Status'] = "Pending";
      request.fields['Receiver'] = selectedCity;
      request.fields['Urgency'] = color;

      if (imageFileList != null) {
        for (int i = 0; i < imageFileList!.length; i++) {
          var stream = http.ByteStream(
              DelegatingStream.typed(imageFileList![i].openRead()));
          var length = await imageFileList![i].length();
          request.files.add(await http.MultipartFile('File', stream, length,
              filename: basename(imageFileList![i].path)));
        }
      }
      if (files != null) {
        for (int i = 0; i < files!.length; i++) {
          var stream = http.ByteStream(
              DelegatingStream.typed(files![i].openRead()));
          var length = await files![i].length();
          request.files.add(await http.MultipartFile('File', stream, length,
              filename: basename(files![i].path)));
        }
      }
      request.send().then((response) async {
        if (response.statusCode == 201) {
          try {
            await _fcmNotificationService.sendNotificationToUser(
              title: 'Approval!',
              body: subject.text,
              fcmToken: _otherDeviceToken,

            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Notification sent.'),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error, ${e.toString()}.'),
              ),
            );
          }


          Fluttertoast.showToast(
              msg: 'Sent Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Information(search: 'null',)));
        } else {
          Fluttertoast.showToast(
              msg: response.statusCode.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
        setState(() {
          _isPressed = false;
          btnTxt = 'ASK APPROVAL';
        });
      });
    }
  }
    List<File> files=[];
  List<String> docfilename=[];
   var doclength;
  FilePickerResult? result;
  void _pickDocFile() async {

     result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom,allowedExtensions: ['doc','pdf']);
    if (result == null) return;
      files = result!.paths.map((path) => File(path!)).toList();
   // file = result!.files.first;
   //   List<File> docfilename = result!.paths.map((path) => File(name!)).toList();
    setState((){
        doclength = files.length;


    });
     // for(int i=0;i<files.length;i++)

  // print(files[i].path.split('/').last);

    print(files.length);

  }
  List<File>? imageFileList = [];

  getImagebyGallery() async {
    try {
      final List<XFile>? selectedImages =
          await _picker.pickMultiImage(maxHeight: 1080, maxWidth: 1920);
      if (selectedImages != null) {
        setState(() {
          for (int s = 0; s < selectedImages.length; s++) {
            imageFileList!.add(File(selectedImages[s].path));
          }
        });
      }
    } on Exception catch (ex) {
      print(ex);
    }
  }

  getImagebyCamera() async {
    PickedFile? pick = await _picker.getImage(
        source: ImageSource.camera, maxHeight: 1920, maxWidth: 1080);
    if (pick != null) {
      setState(() {
        imageFileList!.add(File(pick.path));
      });
    }
  }
  _launchURL(docurl) async {

    if (await canLaunch(docurl)) {
      await launch(docurl);
    } else {
      throw 'Could not launch $docurl';
    }
  }

  Widget PreviewImg() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for( int j =0;j<files.length;j++)
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    _launchURL(files[j].path);
                    },
                  child: ClipRRect(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(60), // Image radius
                      child: Column(
                        children: [
                          Icon(Icons.note,size: 100,color: Colors.grey,),
                          Text(files[j].path.split('/').last,style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          files.removeAt(j);
                        });
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 70, 70),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: const Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          for (int i = 0; i < imageFileList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(60), // Image radius
                        child: Image.file(
                          File(imageFileList![i].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              imageFileList!.remove(imageFileList![i]);
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 70, 70),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
        ],
      ),
    );

    // return SizedBox(
    //   height: 150,
    //   child: GridView(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 1,
    //       ),
    //       scrollDirection: Axis.horizontal,
    //       children: [
    //         for (int i = 0; i < imageFileList!.length; i++)
    //           Padding(
    //               padding: const EdgeInsets.all(3),
    //               child: Stack(
    //                 children: [
    //                   FittedBox(
    //                     child: Image.file(
    //                       File(imageFileList![i].path),
    //                     ),
    //                     fit: BoxFit.contain,
    //                   ),
    //                   Positioned(
    //                       top: -10,
    //                       left: -5,
    //                       child: IconButton(
    //                         onPressed: () {},
    //                         icon: Container(
    //                           decoration: BoxDecoration(
    //                               color: Colors.red,
    //                               borderRadius: BorderRadius.circular(20)),
    //                           child: Center(
    //                             child: const Icon(
    //                               Icons.close,
    //                               size: 25,
    //                               color: Colors.black38,
    //                             ),
    //                           ),
    //                         ),
    //                       ))
    //                 ],
    //               ))
    //       ]),
    // );
  }

  Widget ShowGroup() {
    GetUsers('All', 'All');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange, style: BorderStyle.solid),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownSearch<String>(
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.orange,
                  size: 28,
                )),
            popupBackgroundColor: Colors.white,
            //mode of dropdown
            mode: Mode.DIALOG,
            //to show search box
            showSearchBox: true,
            showSelectedItems: true,
            //list of dropdown items
            items: UserList,
            validator: (value) {
              if (value == "Select User" || value == null) {
                return "Select Member";
              } else {
                return null;
              }
            },
            // dropdownSearchDecoration: const InputDecoration(labelText: "To"),
            onChanged: (value) {
              setState(() {
                selectedCity = value!;
              });
            },

            //show selected item
            selectedItem: "Select User",
          ),
        ),
      ),
    );
  }

  late File imageFile = File('img/blank.png');
  ImagePicker _picker = ImagePicker();
  late List<String>? UserList = [];
  String selectedCity = "";
  final subject = TextEditingController();
  final content = TextEditingController();

  GetUsers(String dept, String role) {
    void get_data() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetUserLoading?Role=' +
              role +
              '&Dept=' +
              dept +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Approval'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];
        print(jsn);
        // UserList!.removeRange(1,UserList!.length);
        UserList!.clear();
        if (UserList!.length <= 1) {
          for (int i = 0; i < length; i++) {
            UserList!.add(jsn[i]['Employee'].toString().toUpperCase());
          }
        }
      }
    }

    get_data();

    return (UserList);
  }

  void redirectHome(BuildContext context) async {
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

  String selectedRole = "All";
  String selecteddept = "All";
  Widget ShowDept() {
    IntiaGetDepts();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange, style: BorderStyle.solid),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownSearch<String>(
            // popupBackgroundColor: Colors.grey.shade300,
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.home_work,
                  color: Colors.orange,
                  size: 28,
                )),
            //mode of dropdown
            mode: Mode.DIALOG,
            //to show search box
            showSearchBox: true,
            showSelectedItems: true,
            //list of dropdown items
            items: DeptList,
            // label: "Department",
            onChanged: (value) {
              selecteddept = value!;
              IntiaGetRoles(selecteddept);
              GetUsers(selecteddept, selectedRole);
            },
            //show selected item
            selectedItem: "Select Department",
          ),
        ),
      ),
    );
  }

  IntiaGetDepts() {
    void Getdept() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetDepts?dept=0&UserId=' +
              globals.login_id.toString() +
              '&WCode=Approval'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        DeptList!.clear();
        //RoleList = [];
        int length = datalist.length;
        if (DeptList!.length <= 1) {
          for (int i = 0; i < length; i++) {
            DeptList!.add(datalist[i]['DepartmentName'].toString());
          }
        }
      }
    }

    Getdept();
    return DeptList;
  }

  Widget ShowSingle() {
    IntiaGetRoles('All');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownSearch<String>(
          // popupBackgroundColor: Colors.grey.shade300,
          dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.school,
                color: Colors.orange,
                size: 28,
              )),
          //mode of dropdown
          mode: Mode.DIALOG,
          //to show search box
          showSearchBox: true,
          showSelectedItems: true,
          //list of dropdown items
          items: RoleList,
          //  label: "Role",
          onChanged: (value) {
            selectedRole = value!;
            GetUsers(selecteddept, selectedRole);
          },
          //show selected item
          selectedItem: "Select Role",
        ),
      ),
    );
  }

  late List<String>? RoleList = [];

  IntiaGetRoles(String deptname) {
    void GetRoles() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetRoles?ds=' +
              deptname +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Approval'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        //RoleList = [];
        int length = datalist.length;
        RoleList!.clear();
        if (RoleList!.length <= 1) {
          for (int i = 0; i < length; i++) {
            RoleList!.add(datalist[i]['Rolename'].toString());
          }
        }
      }
    }

    GetRoles();
    return RoleList;
  }
}
