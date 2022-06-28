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
import 'package:untitled/Login/home.dart';

import '../Model/users.dart';
import 'Taskview.dart';

final _formKey = GlobalKey<FormState>();

class Addnewtask extends StatefulWidget {
  const Addnewtask({Key? key}) : super(key: key);

  @override
  State<Addnewtask> createState() => _AddnewtaskcreateState();
}

enum colors { red, green, blue }
var setVisiblity = false;
bool _showBadgelow = false;
bool _showBadgemedium = true;
bool _showBadgeurgent = false;

class _AddnewtaskcreateState extends State<Addnewtask> {
  bool _isPressed = false;
  String btnTxt = 'Assign Task';
  @override
  Widget build(BuildContext context) {
    IntiaGetDepts();
    IntiaGetRoles('All');
    GetUsers('All', 'All');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new"),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //if(DeptList!.length>1)
                          ShowDept(),
                        //if(RoleList!.length>1)
                          ShowSingle(),
                        //if(UserList!.length>1)
                          ShowGroup(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Subject",
                              labelStyle:
                                  GoogleFonts.poppins(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2),
                              ),
                              prefixIcon: Icon(
                                Icons.sticky_note_2,
                                color: Colors.orange,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Subject is required';
                              }
                            },
                            controller: subject,
                            maxLines: null,
                            maxLength: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.notes,
                                  color: Colors.orange,
                                ),
                                labelText: "Content",
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black54),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    'Set deadline :   ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black38),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.orange,
                                      size: 30,
                                    )),
                                Text(
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _selectTime(context);
                                    },
                                    icon: Icon(
                                      Icons.access_time,
                                      color: Colors.orange,
                                      size: 30,
                                    )),
                                Text(
                                  " ${selectedTime.hour}:${selectedTime.minute} ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    'Set Preference :   ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black38),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                                    child: Text(
                                                      'Low',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                                color = "BLUE";
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
                                                    child: Text(
                                                      'Medium',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                                    child: Text(
                                                      'Urgent',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor:
                                          Color.fromARGB(255, 49, 49, 49),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 60, vertical: 30),
                                          child: Container(
                                            height: 80,
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
                                                          "Pick Image from Camera",
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
                                                      backgroundColor: Colors.pink,
                                                      onPressed: () {
                                                        getImagebyGallery();
                                                        Navigator.pop(context);
                                                      },
                                                      tooltip:
                                                          "Pick Image from Gallery",
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
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isPressed == false ? ()=>_myCallback(context) : null,
                        //     () async {
                        //   if (_formKey.currentState!.validate()) {
                        //     var Posturi = Uri.parse(
                        //         'https://www.hokybo.com/tms/api/Task/PostCreate');
                        //     var request =
                        //         http.MultipartRequest("POST", Posturi);
                        //     request.fields['Subject'] = subject.text;
                        //     request.fields['Message'] = content.text;
                        //     request.fields['UserID'] =
                        //         globals.login_id.toString();
                        //     request.fields['Status'] = "Pending";
                        //     request.fields['Receiver'] = selectedCity;
                        //     request.fields['Date'] = selectedDate.toString();
                        //     request.fields['time'] =
                        //         (selectedTime.hour.toString() +
                        //                 ":" +
                        //                 selectedTime.minute.toString())
                        //             .toString();
                        //     request.fields['Urgency'] = color;
                        //     if (imageFileList != null) {
                        //       for (int i = 0; i < imageFileList!.length; i++) {
                        //         var stream = http.ByteStream(
                        //             DelegatingStream.typed(
                        //                 imageFileList![i].openRead()));
                        //         var length = await imageFileList![i].length();
                        //         request.files.add(await http.MultipartFile(
                        //             'File', stream, length,
                        //             filename:
                        //                 basename(imageFileList![i].path)));
                        //       }
                        //     }
                        //     request.send().then((response) {
                        //       if (response.statusCode == 201) {
                        //         Fluttertoast.showToast(
                        //             msg: 'Sent Successfully',
                        //             toastLength: Toast.LENGTH_SHORT,
                        //             gravity: ToastGravity.BOTTOM,
                        //             backgroundColor: Colors.green,
                        //             textColor: Colors.white);
                        //
                        //         Navigator.pushReplacement(
                        //             context,
                        //             new MaterialPageRoute(
                        //                 builder: (BuildContext context) =>
                        //                     Task()));
                        //       } else {
                        //         Fluttertoast.showToast(
                        //             msg: response.statusCode.toString(),
                        //             toastLength: Toast.LENGTH_SHORT,
                        //             gravity: ToastGravity.BOTTOM,
                        //             backgroundColor: Colors.red,
                        //             textColor: Colors.white);
                        //       }
                        //     });
                        //   }
                        // },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange.shade800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            btnTxt,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future _myCallback(BuildContext context)async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isPressed = true;
            btnTxt = 'Sending Task...';
          });
          var Posturi = Uri.parse('https://www.hokybo.com/tms/api/Task/PostCreate');
          var request =
              http.MultipartRequest("POST", Posturi);
          request.fields['Subject'] = subject.text;
          request.fields['Message'] = content.text;
          request.fields['UserID'] =
              globals.login_id.toString();
          request.fields['Status'] = "Unopened";
          request.fields['Receiver'] = selectedCity;
          request.fields['Date'] = selectedDate.toString();
          request.fields['time'] =
              (selectedTime.hour.toString() +
                      ":" +
                      selectedTime.minute.toString())
                  .toString();
          request.fields['Urgency'] = color;
          if (imageFileList != null) {
            for (int i = 0; i < imageFileList!.length; i++) {
              var stream = http.ByteStream(
                  DelegatingStream.typed(
                      imageFileList![i].openRead()));
              var length = await imageFileList![i].length();
              request.files.add(await http.MultipartFile(
                  'File', stream, length,
                  filename:
                      basename(imageFileList![i].path)));
            }
          }
          request.send().then((response) {
            if (response.statusCode == 201) {
              Fluttertoast.showToast(
                  msg: 'Sent Successfully',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white);

              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Task()));
            } else {
              Fluttertoast.showToast(
                  msg: response.statusCode.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
            }
            setState((){
              _isPressed=false;
              btnTxt = 'Assign Task';
            });
          });
        }


  }
  String valu = "Low";
  int val = -1;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  var color = "BLUE";
  List<File>? imageFileList = [];
  getImagebyGallery() async {
    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage(
          maxHeight:1920 ,
          maxWidth: 1080);
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
        source: ImageSource.camera,
        maxHeight:1920 ,
        maxWidth: 1080
        );
    if (pick != null) {
      setState(() {
        imageFileList!.add(File(pick.path));
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
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.orange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.orange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
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
                  onTap: ()async{
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
            //mode of dropdown
            mode: Mode.DIALOG,
            //to show search box
            showSearchBox: true,
            showSelectedItems: true,
            //list of dropdown items
            items: UserList,
            validator: (value) {
              if (value == "Select Member" || value == null) {
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
            selectedItem: "Select Member",
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
      final response = await http.get(
        Uri.parse(
            'https://www.hokybo.com/tms/api/Information/GetUserLoading?Role=' +
                role +
                '&Dept=' +
                dept +
                '&UserId=' +
                globals.login_id.toString() +
                '&WCode=Task'),
      );
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
            _id.toString() +
            '&WCode=Task');
    final response = await http.get(url);
    var json1 = jsonDecode(response.body);
    print(json1);
    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }

  String selectedRole = "All";
  String selecteddept = "All";
  late List<String>? DeptList = [];
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
              '&WCode=Task'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        DeptList!.clear();
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
      ),
    );
  }

  late List<String>? RoleList = [];

  IntiaGetRoles(String deptname) {
    void GetRoles() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetRoles?ds=' +
              deptname +
              '&UserID=' +
              globals.login_id.toString() +
              '&WCode=Task'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        RoleList!.clear();
        int length = datalist.length;
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


class AppColor {
  static const RED = "RED";
  static const GREEN = "GREEN";
  static const BLUE = "YELLOW";
  static const DEFAULT = "DEFAULT";

  static const _colorMap = {
    RED: Colors.red,
    GREEN: Colors.green,
    BLUE: Colors.yellowAccent,
    DEFAULT: Colors.green,
  };

  const AppColor._();

  static getColorFor(String color) =>
      _colorMap[color.toUpperCase()] ?? _colorMap[DEFAULT];
}
