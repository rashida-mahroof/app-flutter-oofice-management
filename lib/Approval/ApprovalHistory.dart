import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';

import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Login/home.dart';
import '../Model/users.dart';

class ApprovalHistory extends StatefulWidget {
  final int ApprID;
  const ApprovalHistory({Key? key, required this.ApprID}) : super(key: key);

  @override
  _ApprovalHistoryState createState() => _ApprovalHistoryState();
}

class _ApprovalHistoryState extends State<ApprovalHistory> {
  late int IID = widget.ApprID;
  @override
  Future<List<dynamic>> fetchApprbyid(int ID) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Approval/GetApprovalhistoryByID?ApID=" +
            ID.toString();
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  String _Status(dynamic user) {
    return user['Status'];
  }

  String _Name(dynamic user) {
    return user['Name'];
  }

  String _Date(dynamic user) {
    return user['Date'];
  }

  String _Time(dynamic user) {
    return user['Time'];
  }

  String _Comment(dynamic user) {
    return user['Comment'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'APID' + IID.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
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
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchApprbyid(IID),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(40),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _Time(snapshot.data[i]),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .black45),
                                                    ),
                                                    Text(
                                                        _Date(snapshot.data[i]),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black45))
                                                  ],
                                                ),
                                              ),
                                              width: 100,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (_Status(snapshot.data[i]) ==
                                                        'Created')
                                                      Text(
                                                        'Created by',
                                                        style:
                                                        GoogleFonts.poppins(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .blue,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    if (_Status(
                                                            snapshot.data[i]) ==
                                                        'Approved') //---------------Approved--------------
                                                      Text(
                                                        'Approved by',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    if (_Status(
                                                            snapshot.data[i]) ==
                                                        'Rejected') //--------------rejected--------------------
                                                      Text(
                                                        'Rejected by',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    if (_Status(
                                                            snapshot.data[i]) ==
                                                        'Forwarded')
                                                      Text(
                                                        _Status(snapshot
                                                            .data[i]) +
                                                            ' to',
                                                        style: GoogleFonts
                                                            .poppins(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .teal
                                                                ,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                      if (_Status(snapshot
                                                              .data[i]) ==
                                                          'Shared') //--------------Forwarded or shared---------------
                                                        Text(
                                                          _Status(snapshot
                                                                  .data[i]) +
                                                              ' to',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .orange
                                                                      .shade700,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                    if (_Status(
                                                            snapshot.data[i]) ==
                                                        'Closed') //--------------Forwarded---------------
                                                      Text(
                                                        'Completed by',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    Text(
                                                      _Name(snapshot.data[i]),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        if (_Comment(snapshot.data[i])
                                            .isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: SizedBox(
                                                child: Text(
                                                    'Comment: ' +
                                                        _Comment(
                                                            snapshot.data[i]),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color:
                                                            Colors.black45))),
                                          )
                                      ],
                                    ),
                                  ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Created') //---------------------created----------------------
                                    Positioned(
                                      top: 70,
                                      left: 50,
                                      child: new Container(
                                        height: 200,
                                        width: 1.0,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) == 'Closed' ||
                                      _Status(snapshot.data[i]) ==
                                          'Rejected') //---------------------completed or rejected----------------------
                                    Positioned(
                                      bottom: 50,
                                      left: 50,
                                      child: new Container(
                                        height: 200,
                                        width: 1.0,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) == 'Approved' ||
                                      _Status(snapshot.data[i]) ==
                                          'Forwarded' ||
                                      _Status(snapshot.data[i]) ==
                                          'Shared') //---------------------approved or shared or forwarded----------------------
                                    Positioned(
                                      left: 50,
                                      child: new Container(
                                        height: 200,
                                        width: 1.0,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Rejected') //--------rejected--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.block,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Approved') //--------approved--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Created') //--------created--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.add_circle_outline_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Forwarded') //--------Forwarded--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.forward,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Shared') //--------shared--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.share_sharp,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.orange.shade700,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_Status(snapshot.data[i]) ==
                                      'Closed') //--------completed--------
                                    Positioned(
                                      bottom: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40.0),
                                        child: Container(
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          height: 20.0,
                                          width: 20.0,
                                          decoration: new BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                  // }
                  )
            ],
          ),
        ));
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
