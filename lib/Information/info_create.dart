import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'Info_main.dart';

class InformationCreate extends StatefulWidget {
  const InformationCreate({Key? key}) : super(key: key);

  @override
  State<InformationCreate> createState() => _InformationCreateState();
}

class _InformationCreateState extends State<InformationCreate> {
  var imfile;
  final selectedCities = TextEditingController();
  String selectedEmployee = "All";
  String selectedRole = "All";
  String selecteddept = "All";
  final subject = TextEditingController();
  final content = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  bool _isPressed = false;
  String btnTxt = 'Send Information';
  @override
  Widget build(BuildContext context) {
    IntiaGetDepts();
    IntiaGetRoles('All');
    IntiaGetUsers('All', 'All');
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
        title: const Text('Create Information'),
        centerTitle: true,
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
      body: SafeArea(
          child: Column(
        children: [
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            //if(DeptList!.length>1)
                            ShowDept(),
                            SizedBox(
                              height: 10,
                            ),
                            //if(RoleList!.length>1)
                            ShowSingle(),
                            SizedBox(
                              height: 10,
                            ),
                            //if(UserList!.length>1)
                            ShowGroup(),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     vertical: 10,
                            //   ),
                            //   child: TextFormField(
                            //     decoration: const InputDecoration(
                            //         prefixIcon: Icon(Icons.sticky_note_2),
                            //         labelText: "Subject",
                            //         border: OutlineInputBorder()),
                            //     validator: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return 'Subject is required';
                            //       }
                            //     },
                            //     controller: subject,
                            //     maxLines: null,
                            //   ),
                            // ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 10),
                            //   child: TextFormField(
                            //     decoration: const InputDecoration(
                            //         prefixIcon: Icon(Icons.subject),
                            //         labelText: "Content",
                            //         border: OutlineInputBorder()),
                            //     controller: content,
                            //     maxLines: 3,
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Subject",
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: PreviewImg()),
                                ],
                              ),
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
                                                          "Pick Image form Camera",
                                                      child: const Icon(
                                                          Icons.add_a_photo),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    FloatingActionButton(
                                                      backgroundColor:Colors.pink,
                                                      onPressed: () {
                                                        getimagefromgallery();
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
                                                    ),
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
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _isPressed == false ? () => _myCallback(context) : null,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
          )
        ],
      )),
    );
  }

  Future _myCallback(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isPressed = true;
        btnTxt = 'Sending Info...';
      });
      var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Information/PostCreateInfo');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Subject'] = subject.text;
      request.fields['Content'] = content.text;
      request.fields['CreaterID'] = globals.login_id.toString();
      request.fields['Roletorecieve'] = selectedRole;
      request.fields['Employeetorecieve'] = selectedEmployee;
      request.fields['ImgCount'] = imageFileList!.length.toString();
      request.fields['Selecteddept'] = selecteddept;
      if (imageFileList != null) {
        for (int i = 0; i < imageFileList!.length; i++) {
          var stream = http.ByteStream(
              DelegatingStream.typed(imageFileList![i].openRead()));
          var length = await imageFileList![i].length();
          request.files.add(await http.MultipartFile('File', stream, length,
              filename: basename(imageFileList![i].path)));
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
                  builder: (BuildContext context) => InformationView()));
        } else {
          Fluttertoast.showToast(
              msg: 'Required all fields',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);

        }
        setState(() {
          _isPressed = false;
          btnTxt = 'Send Information';
        });
      });
    }
  }

  late List<String>? RoleList = ['All'];
  late List<String>? UserList = ['All'];
  late List<String>? DeptList = ['All'];

  Widget ShowDept() {
    IntiaGetDepts();
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
          items: DeptList,
          label: "Department",
          onChanged: (value) {
            selecteddept = value!;
            IntiaGetRoles(selecteddept);
            IntiaGetUsers(selecteddept, selectedRole);
          },
          //show selected item
          selectedItem: "All",
        ),
      ),
    );
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
          items: RoleList,
          label: "Role",
          onChanged: (value) {
            selectedRole = value!;
            IntiaGetUsers(selecteddept, selectedRole);
          },
          //show selected item
          selectedItem: "All",
        ),
      ),
    );
  }

  Widget ShowGroup() {
    IntiaGetUsers('All', 'All');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownSearch<String>(
          //mode of dropdown
          // popupBackgroundColor: Colors.grey.shade300,
          dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.orange,
                size: 28,
              )),
          mode: Mode.DIALOG,
          //to show search box
          showSearchBox: true,
          showSelectedItems: true,
          //list of dropdown items
          items: UserList,
          label: "User",
          onChanged: (value) {
            setState(() {
              selectedEmployee = value!;
            });
          },
          //show selected item
          selectedItem: "All",
        ),
      ),
    );
  }

  void Sendinfo() async {
    return null;
  }

  IntiaGetDepts() {
    void Getdept() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetDepts?dept=0&UserId=' +
              globals.login_id.toString() +
              '&WCode=Information'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
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

  IntiaGetRoles(String deptname) {
    void GetRoles() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetRoles?ds=' +
              deptname +
              '&UserID=' +
              globals.login_id.toString() +
              '&WCode=Information'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        //RoleList = [];
        int length = datalist.length;
        RoleList!.removeRange(1, RoleList!.length);
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

  IntiaGetUsers(String dept, String role) {
    void GetUsers() async {
      final response1 = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetUserLoading?Role=' +
              role +
              '&Dept=' +
              dept +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Information'));
      final List<dynamic> lis;
      if (response1.statusCode == 200) {
        lis = jsonDecode(response1.body);
        // UserList = [];
        int lenth = lis.length;
        UserList!.removeRange(1, UserList!.length);
        if (UserList!.length <= 1) {
          for (int i = 0; i < lenth; i++) {
            UserList!.add(lis[i]['Employee'].toString().toUpperCase());
          }
        }
      }
    }

    GetUsers();
    return UserList;
  }

  Future getimagefromgallery() async {
    try {
      final List<XFile>? selectedImages =
          await imagePicker.pickMultiImage(maxHeight: 1920, maxWidth: 1080);

      setState(() {
        if (selectedImages!.isNotEmpty) {
          for (int s = 0; s < selectedImages.length; s++) {
            imageFileList!.add(File(selectedImages[s].path));
          }
        }
      });
    } on Exception catch (ex) {
      print(ex);
    }
  }

  getImagebyCamera() async {
    PickedFile? pick = await imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 1920, maxWidth: 1080);
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
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 100,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.fill,
          //       image: NetworkImage("https://picsum.photos/250?image=9"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  List<Container> _buildGridTileList(int count) {
    return List<Container>.generate(
        count,
        (int index) => Container(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.file(
                  File(imageFileList![index].path),
                  width: 96.0,
                  height: 96.0,
                  fit: BoxFit.contain,
                ),
              ],
            )));
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
}
