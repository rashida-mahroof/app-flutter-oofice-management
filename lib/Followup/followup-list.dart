import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Followup/followup-details.dart';
import 'package:untitled/Login/globals.dart' as globals;
import '../Login/home.dart';
import '../Model/users.dart';

class FollowupList extends StatefulWidget {
  const FollowupList({Key? key}) : super(key: key);

  @override
  State<FollowupList> createState() => _FollowupListState();
}

class _FollowupListState extends State<FollowupList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followups'),
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
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From Date',style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 11),),
                        SizedBox(height: 3,),
                        GestureDetector(
                          onTap: () {
                            _selectfrmDate(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.deepOrange,
                                border: Border.all(
                                    color: Colors.grey
                                        .shade300),
                                borderRadius: BorderRadius
                                    .circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _selectfrmDate(
                                            context);
                                      },
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.orange,
                                        size: 30,
                                      )),
                                  Text(
                                    "${selectedfrmDate
                                        .day}/${selectedfrmDate
                                        .month}/${selectedfrmDate
                                        .year}",
                                    style: GoogleFonts
                                        .poppins(
                                        color: Colors.grey
                                            .shade700,
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To Date',style: GoogleFonts.poppins(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 11),),
                        SizedBox(height: 3,),
                        GestureDetector(
                          onTap: () {
                            _selecttoDate(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.deepOrange,
                                border: Border.all(
                                    color: Colors.grey
                                        .shade300),
                                borderRadius: BorderRadius
                                    .circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets
                                  .symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _selecttoDate(
                                            context);
                                      },
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.orange,
                                        size: 30,
                                      )),
                                  Text(
                                    "${selectedtoDate
                                        .day}/${selectedtoDate
                                        .month}/${selectedtoDate
                                        .year}",
                                    style: GoogleFonts
                                        .poppins(
                                        color: Colors.grey
                                            .shade700,
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              for(int i= 1;i<8;i++)
              Card(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowupDetails()));
                          },
                          title: Row(
                            children: [
                              Text('12-02-2022',style: GoogleFonts.poppins(
                                  fontSize: 11, color: Colors.black54),)
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(1==2)  //if possibility is hot
                                Text(
                                  "HOT",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.green),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if(1==1) //if possibility is warm
                                Text(
                                  "WARM",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.yellow.shade800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if(1==2) //if possibility is cold
                                Text(
                                  "COLD",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.deepOrange),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                "Dr. Francis Chakko",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Follow up on: 04-06-2022",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                          trailing: Column(
                            children: [
                              IconButton(onPressed: (){}, icon:  Icon(
                                Icons.call,
                                color: Colors.green,
                                size: 30,
                              ),),

                            ],
                          ),
                        ),
                      )

            ],
          ),
        ),
      ),
    );
  }
  DateTime selectedfrmDate = DateTime.now();
  DateTime selectedtoDate = DateTime.now();
  _selectfrmDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedfrmDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.deepOrange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (selected != null && selected != selectedfrmDate)
      setState(() {
        selectedfrmDate = selected;
      });
  }
  _selecttoDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedtoDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.deepOrange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (selected != null && selected != selectedtoDate)
      setState(() {
        selectedtoDate = selected;
      });
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
}
