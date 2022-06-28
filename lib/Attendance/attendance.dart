import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Login/home.dart';
import '../Model/users.dart';
import 'package:untitled/Login/globals.dart' as globals;


class attendanceDetails extends StatefulWidget {
  const attendanceDetails({Key? key}) : super(key: key);

  @override
  State<attendanceDetails> createState() => _attendanceDetailsState();
}

class _attendanceDetailsState extends State<attendanceDetails> {
  final fromdate = TextEditingController();
  final todate = TextEditingController();
  DateTime date1 = DateTime.now();
  int cont = 5;

  var _isDataVisible = false;
  String Name(dynamic user) {
    return user['Name'];
  }

  String Date(dynamic user) {
    return user['Date'];
  }
  String Day(dynamic user) {
    return user['Day'];
  }
  String Status(dynamic user) {
    return user['Status'];
  }

  String Entry(dynamic user) {
    return user['Entry'];
  }

  String Exit(dynamic user) {
    return user['Exit'];
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
          title: const Text("Attendance"),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [

                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Text(
                              'Member Attendance',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),

                      //if(DeptList!.length>1)
                      ShowDept(),
                      //if(RoleList!.length>1)
                      ShowSingle(),
                      //if(UserList!.length>1)
                      ShowGroup(),
                    ],
                  ),
                FutureBuilder<List<dynamic>>(
                  future: fetchattendance(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Padding(
                        padding: const EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                // child: Row(
                                //   children: [
                                //     Text(
                                //       'My Attendance',
                                //       style: GoogleFonts.poppins(
                                //           fontWeight: FontWeight.w600,
                                //           color: Colors.teal,
                                //           fontSize: 14),
                                //     )
                                //   ],
                                // ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.orange.shade50)
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller:
                                              fromdate, //editing controller of this TextField
                                          decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.orange,
                                              ), //icon of text field
                                              labelText:
                                                  "From Date" //label text of field
                                              ),
                                          readOnly:
                                              true, //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime(2101));
                                            builder:
                                            (context, child) {
                                              return Theme(
                                                  data:
                                                      ThemeData.light().copyWith(
                                                    primaryColor: Colors.orange,
                                                    accentColor:
                                                        const Color(0xFF8CE7F1),
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary: const Color(
                                                                0xFFFF7636)),
                                                    buttonTheme: ButtonThemeData(
                                                        textTheme: ButtonTextTheme
                                                            .primary),
                                                  ),
                                                  child: child!);
                                            };
                                            if (pickedDate != null) {
                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement

                                              fromdate.text = formattedDate;

                                              date1 = pickedDate;
                                              //set output date to TextField value.

                                            } else {
                                              print("Date is not selected");
                                            }
                                          }),
                                    ),
                                    Expanded(
                                      child: TextField(
                                          controller:
                                              todate, //editing controller of this TextField
                                          decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.orange,
                                              ), //icon of text field
                                              labelText:
                                                  "To Date" //label text of field
                                              ),
                                          readOnly:
                                              true, //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime.now());
                                            builder:
                                            (context, child) {
                                              return Theme(
                                                  data:
                                                      ThemeData.light().copyWith(
                                                    primaryColor: Colors.orange,
                                                    accentColor:
                                                        const Color(0xFF8CE7F1),
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary: const Color(
                                                                0xFFFF7636)),
                                                    buttonTheme: ButtonThemeData(
                                                        textTheme: ButtonTextTheme
                                                            .primary),
                                                  ),
                                                  child: child!);
                                            };
                                            if (pickedDate != null) {
                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              //formatted date output using intl package =>  2021-03-16
                                              //you can implement different kind of Date Format here according to your requirement

                                              setState(() {
                                                todate.text = formattedDate; //s
                                                final date2 = pickedDate; //
                                                cont = date2
                                                    .difference(date1)
                                                    .inDays;
                                                // et output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          }),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if (snapshot.hasData)
                                Table(
                                  border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.orange.shade300),
                                  // textDirection: TextDirection.ltr,
                                  children: [
                                    TableRow(children: [
                                      Table(
                                        children: [
                                          TableRow(children: [
                                            Container(
                                              decoration: BoxDecoration(
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  Name(snapshot.data[0]),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                    ]),

                                    TableRow(children: [
                                      Table(
                                        border: TableBorder.all(
                                            width: 1.0,
                                            color: Colors.orange.shade100),
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                'Date',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                'Entry',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                'Exit',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                'Status',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ]),
                                          for (int i = 0; i <= cont; i++)

                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      Date(snapshot.data[i]),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: Colors.black87,
                                                        // fontWeight: FontWeight.w500
                                                      ),
                                                    ),


                                                    Text(
                                                      Day(snapshot.data[i]),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        fontWeight:FontWeight.w500,
                                                        color: (Day(snapshot.data[i])=='Sunday')?Colors.red:Colors.teal.shade800,
                                                        // fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  Entry(snapshot.data[i]),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    // fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  Exit(snapshot.data[i]),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    // fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  Status(snapshot.data[i]),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,

                                                    color: (Status(snapshot
                                                                .data[i]) ==
                                                            "Leave")
                                                        ? Colors.red
                                                        : Colors.black,
                                                    // fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ]),
                                        ],
                                      )
                                    ]),
                                  ],
                                )
                            ],
                          ),
                        ));
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future<List<dynamic>> fetchattendance() async {
    final String apiUrl =
        'https://www.hokybo.com/TMS/api/Attendance/GetEmployeeattendByID?UserID=' +
            selectedUserID.toString() +
            '&Fromdate=' +
            fromdate.text +
            '&Todate=' +
            todate.text;
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
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

    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }
//Dropdowns

  late List<String>? UserList = [];
  late List<String>? DeptList = [];

  String selectedRole = "";
  String selectedUser = globals.login_id.toString();
  String selecteddept = "";
  int selectedUserID = globals.login_id;

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
                  color: Colors.grey,
                  size: 28,
                )),
            popupBackgroundColor: Colors.white,
            //mode of dropdown
            mode: Mode.MENU,
            //to show search box
            showSearchBox: true,
            showSelectedItems: true,
            //list of dropdown items
            items: UserList,
            // validator: (value) {
            //   if (value == "Select User" || value == null) {
            //     return "Select Employee";
            //   } else {
            //     return null;
            //   }
            // },
            // dropdownSearchDecoration: const InputDecoration(labelText: "To"),
            onChanged: (value) {
              setState(() {
                selectedUser = value!;
                getUserID(selectedUser);
              });
            },

            //show selected item
            selectedItem: "Select User",
          ),
        ),
      ),
    );
  }

  GetUsers(String dept, String role) {
    void get_data() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetUserLoading?Role=' +
              role +
              '&Dept=' +
              dept +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Attendance'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];

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
                  color: Colors.grey,
                  size: 28,
                )),
            //mode of dropdown
            mode: Mode.BOTTOM_SHEET,
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
              '&WCode=Attendance'));
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
                color: Colors.grey,
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
              '&WCode=Attendance'));
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

  getUserID(String UserName) async {
    final response = await http.get(Uri.parse(
        'https://www.hokybo.com/tms/api/Attendance/GetUserID?UserName=' +
            UserName));
    if (response.statusCode == 200) {
      var id = jsonDecode(response.body);
      selectedUserID = id['UserID'];
      setState(() {
        selectedUserID;
      });
    }
  }
}
