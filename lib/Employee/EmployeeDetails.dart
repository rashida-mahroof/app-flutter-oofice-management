import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

import '../Login/home.dart';
import '../Model/users.dart';

class EmployeeById extends StatefulWidget {
  final int EmployeeID;

  const EmployeeById({Key? key, required this.EmployeeID}) : super(key: key);

  @override
  State<EmployeeById> createState() => _EmployeeByIdState();
}

class _EmployeeByIdState extends State<EmployeeById>
    with TickerProviderStateMixin {
  late int IID = widget.EmployeeID;

  @override
  Future<List<dynamic>> fetchInfobyid(int ID) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Employee/GetEmployeeByID?UserID=" +
            ID.toString();
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  String _EmployeeCode(dynamic user) {
    return user['EmployeeCode'];
  }

  String _Ename(dynamic user) {
    return user['Name'];
  }

  String _Role(dynamic user) {
    return user['Role'];
  }

  String _Mobile(dynamic user) {
    return user['Mobile'];
  }

  String _Email(dynamic user) {
    return user['Email'];
  }

  String _cmpnymail(dynamic user) {
    return user['CompanyMail'];
  }

  String _cmpnymob(dynamic user) {
    return user['CompanyMob'];
  }

  Widget build(BuildContext ctx) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Member Details'),
            centerTitle: true,
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
          body: FutureBuilder<List<dynamic>>(
            future: fetchInfobyid(IID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    // height: double.maxFinite,
                    decoration: BoxDecoration(
                        // color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),

                        CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            "https://www.hokybo.com/assets/Users/" +
                                IID.toString() +
                                ".jpg?",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black45, fontSize: 12),
                                ),
                                Text(
                                  _Ename(snapshot.data[0]),
                                  style: GoogleFonts.poppins(
                                      //   fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Icon(
                                  Icons.hourglass_bottom,
                                  size: 40,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Role',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    _Role(snapshot.data[0]),
                                    style: GoogleFonts.poppins(
                                        //   fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //  Text(_Role(snapshot.data[0])),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Icon(
                                  Icons.password,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Member Code',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black45, fontSize: 12),
                                ),
                                Text(
                                  _EmployeeCode(snapshot.data[0]),
                                  style: GoogleFonts.poppins(
                                      // fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //Text(_Mobile(snapshot.data[0])),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Icon(
                                  Icons.mail_outline,
                                  size: 40,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontSize: 12),
                                  ),
                                  if( _cmpnymail(snapshot.data[0])!='')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Official',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black26,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        _cmpnymail(snapshot.data[0]),
                                        style: GoogleFonts.poppins(
                                            //  fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  if( _Email(snapshot.data[0])!='')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personal',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black26,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        _Email(snapshot.data[0]),
                                        style: GoogleFonts.poppins(
                                            //  fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //Text(_Email(snapshot.data[0])),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Icon(
                                    Icons.mobile_friendly,
                                    size: 40,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            // if (_Mobile(snapshot.data[0]) != '')
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontSize: 12),
                                  ),
                                  if (_cmpnymob(snapshot.data[0]) != '')
                                    Row(
                                      children: [
                                        Text(
                                          _cmpnymob(snapshot.data[0]),
                                          style: GoogleFonts.poppins(
                                              //   fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          ' - Official',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black26,
                                              fontSize: 10),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            _makePhoneCall(
                                                _Mobile(snapshot.data[0]));
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Icon(Icons.call,
                                                color: Colors.green,
                                                size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (_Mobile(snapshot.data[0]) != '')
                                    Row(
                                      children: [
                                        Text(
                                          _Mobile(snapshot.data[0]),
                                          style: GoogleFonts.poppins(
                                              //   fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          ' - Personal',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black26,
                                              fontSize: 10),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            _makePhoneCall(
                                                _Mobile(snapshot.data[0]));
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Icon(Icons.call,
                                                color: Colors.green,
                                                size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            // new Spacer(),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Icon(
                            //       Icons.call,
                            //       color: Colors.green,
                            //     ),
                            //   ),
                            // ),
                            if (_Mobile(snapshot.data[0]) != '') Divider(),
                          ],
                        ),
                        //Text(_EmployeeCode(snapshot.data[0])),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
