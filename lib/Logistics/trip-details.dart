// import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Logistics/trips-list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/Login/globals.dart' as globals;
// import 'package:scroll_navigation/misc/navigation_helpers.dart';
// import 'package:scroll_navigation/navigation/scroll_navigation.dart';
import 'edit-trip.dart';

class TripDetails extends StatefulWidget {
  final List<dynamic> Obj;
  const TripDetails({Key? key, required this.Obj}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

Color _initialColor = Colors.yellow.shade700;
bool _isVisible = true;

class _TripDetailsState extends State<TripDetails> {
  late TabController _tabController;
  String TID = '';
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
    TID = 'Trip ID: V' + widget.Obj[0]['TripId'].toString();
  }

  Future<List<dynamic>> fetchtripbyid(int ID, String Type) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Trip/GetTripdtlByID?TripID=" +
            ID.toString() +
            "&Type=" +
            Type;
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  String _Status(dynamic user) {
    return user['Status'];
  }

  String _Date(dynamic user) {
    return user['Date'];
  }

  String _RouteName(dynamic user) {
    return user['RouteName'];
  }

  int _BranchId(dynamic user) {
    return user['BranchId'];
  }

  String _Time(dynamic user) {
    return user['Time'];
  }

  int _StatusID(dynamic user) {
    return user['StatusID'];
  }

  @override
  Widget build(BuildContext context) {
    var  size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(TID.toString()),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.edit_outlined,
              //     size: 25,
              //   ),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => EditTrip()));
              //   },
              //   tooltip: 'Edit Trip',
              // ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 25,
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Container(
                        height: 90,
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: 50,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Do you want to delete this Trip ?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            DeleteTrip(widget.Obj[0]['TripId']);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Delete Trip',
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle No',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Colors.orange.shade500),
                    ),
                    Text(
                      widget.Obj[0]['VehicleNum'],
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Colors.orange.shade500),
                    ),
                    Row(
                      children: [
                        Text(widget.Obj[0]['DriverNum'],
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45)),
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      _makePhoneCall(widget.Obj[0]['Mobile']);
                    },
                    tooltip: 'Call ',
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ))
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 10),
            //     child: Column(
            //       children: [
            //         Stack(
            //           children: [
            //             Container(
            //               width: double.maxFinite,
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: Colors.orange.shade200),
            //                   borderRadius: BorderRadius.circular(8)),
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 20, horizontal: 6),
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //
            //                         Row(
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.only(right: 8),
            //                               child: Icon(Icons.calendar_month,color: Colors.grey.shade600,),
            //                             ),
            //                             Text('Started on: ',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 11,
            //                                     color: Colors.black54),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                         Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Text('10:37 AM',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 12,
            //                                     ),
            //                                 textAlign: TextAlign.justify),
            //                             Text('28 Sat 2022',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 12,
            //                                    ),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.only(right: 8),
            //                               child: Icon(Icons.local_shipping,color: Colors.grey.shade600,),
            //                             ),
            //                             Text('Space Status:',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 11,
            //                                     color: Colors.black54),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                         Text('75% vacant',
            //                             style: GoogleFonts.poppins(
            //                               //color: Colors.white,
            //                                 fontSize: 12,
            //                                 ),
            //                             ),
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //
            //               ),
            //             ),
            //             Positioned(
            //               left: 5,
            //               top: -5,
            //               child: Container(
            //                   color: Colors.grey[50],
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 8),
            //                     child: Text(
            //                       'Trip Up',
            //                       style: GoogleFonts.poppins(
            //                           fontSize: 11,
            //                           color: Colors.orange.shade500),
            //                     ),
            //                   )),
            //             )
            //           ],
            //         ),
            //         SizedBox(height: 10,),
            //         Stack(
            //           children: [
            //             Container(
            //               width: double.maxFinite,
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: Colors.orange.shade200),
            //                   borderRadius: BorderRadius.circular(8)),
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 20, horizontal: 6),
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //
            //                         Row(
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.only(right: 8),
            //                               child: Icon(Icons.calendar_month,color: Colors.grey.shade600,),
            //                             ),
            //                             Text('Started on: ',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 11,
            //                                     color: Colors.black54),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                         Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Text('10:37 AM',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 12,
            //                                     ),
            //                                 textAlign: TextAlign.justify),
            //                             Text('28 Sat 2022',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 12,
            //                                     ),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.only(right: 8),
            //                               child: Icon(Icons.local_shipping,color: Colors.grey.shade600,),
            //                             ),
            //                             Text('Space Status:',
            //                                 style: GoogleFonts.poppins(
            //                                   //color: Colors.white,
            //                                     fontSize: 11,
            //                                     color: Colors.black54),
            //                                 textAlign: TextAlign.justify),
            //                           ],
            //                         ),
            //                         Text('75% vacant',
            //                             style: GoogleFonts.poppins(
            //                               //color: Colors.white,
            //                                 fontSize: 12,
            //                                ),
            //                             textAlign: TextAlign.justify),
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //
            //               ),
            //             ),
            //             Positioned(
            //               left: 5,
            //               top: -5,
            //               child: Container(
            //                   color: Colors.grey[50],
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 8),
            //                     child: Text(
            //                       'Trip Down',
            //                       style: GoogleFonts.poppins(
            //                           fontSize: 11,
            //                           color: Colors.orange.shade500),
            //                     ),
            //                   )),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    // ButtonsTabBar(
                    //
                    //   backgroundColor: Colors.orange.shade800,
                    //   unselectedBackgroundColor: Colors.grey[300],
                    //   unselectedLabelStyle: TextStyle(color: Colors.black),
                    //   labelStyle:
                    //   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    //   tabs: [
                    //     Tab(
                    //       icon: Icon(Icons.local_shipping_outlined,size: 30,),
                    //       text: "Trip Details",
                    //     ),
                    //     Tab(
                    //       icon: Icon(Icons.alt_route,size: 30,),
                    //       text: "Route Up",
                    //
                    //     ),
                    //     Tab(
                    //       icon: Icon(Icons.route,size: 30,),
                    //       text: "Route Down",
                    //     ),
                    //
                    //   ],
                    // ),
                    Expanded(
                      // height: 450,
                      child: TabBarView(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.orange.shade200),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 6),
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    widget.Obj[0]
                                                        ['Up_RouteNam'],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '(' +
                                                        widget.Obj[0]['UpKm']
                                                            .toString() +
                                                        ' Kilometers)',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.black54),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(
                                                          Icons.calendar_month,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Text('Started on: ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  //color: Colors.white,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          widget.Obj[0]
                                                              ['Up_time'],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            //color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign
                                                              .justify),
                                                      Text(
                                                          widget.Obj[0]
                                                              ['Up_dates'],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            //color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(
                                                          Icons.local_shipping,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Text('Space Status:',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  //color: Colors.white,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                  Text(
                                                    widget.Obj[0]['Up_Space'],
                                                    style: GoogleFonts.poppins(
                                                      //color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5,
                                        top: -5,
                                        child: Container(
                                            color: Colors.grey[50],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                'Trip Up',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    color:
                                                        Colors.orange.shade500),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.orange.shade200),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 6),
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    widget.Obj[0]
                                                        ['Down_RouteNo'],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black87,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '(' +
                                                        widget.Obj[0]['DownKm']
                                                            .toString() +
                                                        ' Kilometers)',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Colors.black54),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(
                                                          Icons.calendar_month,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Text('Started on: ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  //color: Colors.white,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          widget.Obj[0]
                                                              ['Down_time'],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            //color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign
                                                              .justify),
                                                      Text(
                                                          widget.Obj[0]
                                                              ['Down_dates'],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            //color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 8),
                                                        child: Icon(
                                                          Icons.local_shipping,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Text('Space Status:',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  //color: Colors.white,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black54),
                                                          textAlign: TextAlign
                                                              .justify),
                                                    ],
                                                  ),
                                                  Text(
                                                    widget.Obj[0]['Down_Space'],
                                                    style: GoogleFonts.poppins(
                                                      //color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5,
                                        top: -5,
                                        child: Container(
                                            color: Colors.grey[50],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                'Trip Down',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    color:
                                                        Colors.orange.shade500),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: FutureBuilder(
                              future:
                                  fetchtripbyid(widget.Obj[0]['TripId'], 'U'),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: index == 0
                                                      ? Colors.white30
                                                      : Colors.black26,
                                                ),
                                                //--------------if trip not started-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Pending')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors
                                                            .yellow.shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                          if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index])){
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .start,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    index==0?
                                                                    Text(
                                                                      'Do you want to Start this Trip ?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                    ):Text(
                                                                      'Do you want to Verify this Trip ?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      ()async {
                                                                    String stts='';
                                                                        if(index==0)
                                                                        {
                                                                          stts='Started';
                                                                        }
                                                                        else
                                                                        {
                                                                          stts='Verified';
                                                                        }
                                                                        var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Status'] = stts;
      request.fields['UserID'] = globals.login_id.toString();
      request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      request.fields['Type'] = 'U';

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
                  builder: (BuildContext context) => TripDetails(Obj:  widget.Obj)));
        } else {
          Fluttertoast.showToast(
              msg: 'Required all fields',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);

        }
        // setState(() {
        //   _isPressed = false;
        //   btnTxt = 'Send Information';
        // });
      });
                                                                      },
                                                                  child: index==0? const Text(
                                                                      'Start'):const Text(
                                                                      'Verify'),
                                                                ),
                                                              ],
                                                            ),
                                                          );}
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if started-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Started')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors
                                                            .green.shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if reached at branch-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Reached')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors.blueAccent
                                                            .shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .cloud_done,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Do you want to Verify this Trip ?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      ()async {
      //                                                                   if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index]))
      //                                                                   {
      //                                                                     String stts='';
      //                                                                   if(index==0)
      //                                                                   {
      //                                                                     stts='Started';
      //                                                                   }
      //                                                                   else
      //                                                                   {
      //                                                                     stts='Verified';
      //                                                                   }
      //                                                                   var Posturi = Uri.parse(
      //     'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      // var request = http.MultipartRequest("POST", Posturi);
      // request.fields['Status'] = stts;
      // request.fields['UserID'] = globals.login_id.toString();
      // request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      // request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      // request.fields['Type'] = 'U';

      // request.send().then((response) {
      //   if (response.statusCode == 201) {
      //     Fluttertoast.showToast(
      //         msg: 'Sent Successfully',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         backgroundColor: Colors.green,
      //         textColor: Colors.white);

      //     // Navigator.pushReplacement(
      //     //     context,
      //     //     new MaterialPageRoute(
      //     //         builder: (BuildContext context) => InformationView()));
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: 'Required all fields',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white);

      //   }
      //   // setState(() {
      //   //   _isPressed = false;
      //   //   btnTxt = 'Send Information';
      //   // });
      // });

                                                                      
      //                                                                   }
                                                                        },
                                                                  child: const Text(
                                                                      'Verify'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if reached at branch & verified by BM-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Verified')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors.teal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if Trip end-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Ended')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color:
                                                            Colors.deepOrange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                          if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index])){

                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .stop_circle,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Do you want to End this Trip ?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      ()async {
                                                                        String stts='End';
                                                                        
                                                                        var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Status'] = stts;
      request.fields['UserID'] = globals.login_id.toString();
      request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      request.fields['Type'] = 'U';

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
                  builder: (BuildContext context) => TripDetails(Obj:  widget.Obj)));
        } else if(response.statusCode == 405){
          Fluttertoast.showToast(
              msg: 'Previous branch not verified',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);

        }
        else {
        Fluttertoast.showToast(
        msg: 'Required all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white);

        }
        // setState(() {
        //   _isPressed = false;
        //   btnTxt = 'Send Information';
        // });
      });
                                                                      },
                                                                  child: const Text(
                                                                      'Verify'),
                                                                ),
                                                              ],
                                                            ),
                                                          );}
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: Colors.black26,
                                                  // color: index == totaldatacount.length-1 == 0 ? Colors.white : Colors.black26,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Visibility(
                                                visible: true,
                                                child: Container(
                                                  width:width/3,
                                                  decoration:const BoxDecoration(
                                                        // borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _Time(snapshot
                                                              .data[index]),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black45),
                                                        ),
                                                        Text(
                                                            _Date(snapshot
                                                                .data[index]),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 12,
                                                                    color: Colors
                                                                        .black54)),
                                                        Text(
                                                            _Status(snapshot
                                                                .data[index]),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 13,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                      });
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                          Center(
                            child: FutureBuilder(
                              future:
                                  fetchtripbyid(widget.Obj[0]['TripId'], 'D'),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: index == 0
                                                      ? Colors.white30
                                                      : Colors.black26,
                                                ),
                                                //--------------if trip not started-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Pending')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors
                                                            .yellow.shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index]))
                                                         {
                                                          
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                            context) =>
                                                                AlertDialog(
                                                                  content:
                                                                  Container(
                                                                    height: 100,
                                                                    child: Column(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .start,
                                                                          size: 50,
                                                                          color: Colors
                                                                              .green,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        index==0?
                                                                        Text(
                                                                          'Do you want to Start this Trip ?',
                                                                          textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize:
                                                                              14,
                                                                              color:
                                                                              Colors.black45),
                                                                        ):Text(
                                                                          'Do you want to Verify this Trip ?',
                                                                          textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize:
                                                                              14,
                                                                              color:
                                                                              Colors.black45),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator.pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          ()async {
                                                                            
                                                                          String stts='';
                                                                        if(index==0)
                                                                        {
                                                                          stts='Started';
                                                                        }
                                                                        else
                                                                        {
                                                                          stts='Verified';
                                                                        }
                                                                        var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Status'] = stts;
      request.fields['UserID'] = globals.login_id.toString();
      request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      request.fields['Type'] = 'D';

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
                  builder: (BuildContext context) => TripDetails(Obj:  widget.Obj)));
        } else {
          Fluttertoast.showToast(
              msg: 'Required all fields',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);

        }
        // setState(() {
        //   _isPressed = false;
        //   btnTxt = 'Send Information';
        // });
      });
                                                                          },
                                                                      child: index==0? const Text(
                                                                          'Start'): const Text(
                                                                          'Verify'),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );}
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if started-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Started')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors
                                                            .green.shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if reached at branch-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Reached')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors.blueAccent
                                                            .shade700,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
    if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index]))
    {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              content:
                                                                  Container(
                                                                height: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .cloud_done,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      'Do you want to Verify this Trip ?',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black45),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {

      //                                                                     String stts='';
      //                                                                   if(index==0)
      //                                                                   {
      //                                                                     stts='Started';
      //                                                                   }
      //                                                                   else
      //                                                                   {
      //                                                                     stts='Verified';
      //                                                                   }
      //                                                                   var Posturi = Uri.parse(
      //     'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      // var request = http.MultipartRequest("POST", Posturi);
      // request.fields['Status'] = stts;
      // request.fields['UserID'] = globals.login_id.toString();
      // request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      // request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      // request.fields['Type'] = 'D';

      // request.send().then((response) {
      //   if (response.statusCode == 201) {
      //     Fluttertoast.showToast(
      //         msg: 'Sent Successfully',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         backgroundColor: Colors.green,
      //         textColor: Colors.white);

      //     // Navigator.pushReplacement(
      //     //     context,
      //     //     new MaterialPageRoute(
      //     //         builder: (BuildContext context) => InformationView()));
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: 'Required all fields',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         backgroundColor: Colors.red,
      //         textColor: Colors.white);

      //   }
      //   // setState(() {
      //   //   _isPressed = false;
      //   //   btnTxt = 'Send Information';
      //   // });
      // });

                                                                      

                                                                      },
                                                                  child: const Text(
                                                                      'Verify'),
                                                                ),
                                                              ],
                                                            ),
                                                          );}
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if reached at branch & verified by BM-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Verified')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color: Colors.teal,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // _initialColor = Colors.green;
                                                            // _isVisible = !_isVisible;
                                                          });
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                //--------------if Trip end-------------------
                                                if (_Status(
                                                        snapshot.data[index]) ==
                                                    'Ended')
                                                  Container(
                                                    height: 75,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 2),
                                                        color:
                                                            Colors.deepOrange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          if((globals.RoleId==51 || globals.RoleId==14) && globals.BranchID==_BranchId(snapshot.data[index]))
                                                          {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                            context) =>
                                                                AlertDialog(
                                                                  content:
                                                                  Container(
                                                                    height: 100,
                                                                    child: Column(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .stop_circle,
                                                                          size: 50,
                                                                          color: Colors
                                                                              .red,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                          10,
                                                                        ),
                                                                        Text(
                                                                          'Do you want to End this Trip ?',
                                                                          textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize:
                                                                              14,
                                                                              color:
                                                                              Colors.black45),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator.pop(
                                                                              context,
                                                                              'Cancel'),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                            
                                                                          String stts='End';
                                                                       
                                                                        var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/UpdateStatus');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Status'] = stts;
      request.fields['UserID'] = globals.login_id.toString();
      request.fields['TripID'] =  widget.Obj[0]['TripId'].toString();
      request.fields['RouteDetailID'] = _StatusID(snapshot.data[index]).toString();
      request.fields['Type'] = 'D';

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
                  builder: (BuildContext context) => TripDetails(Obj:  widget.Obj)));
        } else {
          Fluttertoast.showToast(
              msg: 'Required all fields',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);

        }
        // setState(() {
        //   _isPressed = false;
        //   btnTxt = 'Send Information';
        // });
      });
                                                                          },
                                                                      child: const Text(
                                                                          'End'),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        }
                                                        },
                                                        child: Text(
                                                          _RouteName(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: Colors.black26,
                                                  // color: index == totaldatacount.length-1 == 0 ? Colors.white : Colors.black26,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Visibility(
                                                visible: true,
                                                child: Container(
                                                  width:width/3,
                                                  decoration: BoxDecoration(
                                                      // color: Color(0xFFE3E3E3),
                                                      // boxShadow: [BoxShadow(
                                                      //     color: Colors.grey,
                                                      //     blurRadius: 2.0,
                                                      //     offset: Offset(.3,1)
                                                      // ),],
                                                      // border: Border.all(color: Colors.orange),
                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _Time(snapshot
                                                            .data[index]),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black45),
                                                      ),
                                                      Text(
                                                          _Date(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54)),
                                                      Text(
                                                          _Status(snapshot
                                                              .data[index]),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                      });
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DeleteTrip(int TripID) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Trip/DeleteTrip?TripID=" +
            TripID.toString();
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Deleted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => const TripsList()));
    } else {
      Fluttertoast.showToast(
          msg: 'Error Occured',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      Navigator.of(context, rootNavigator: true).pop();
    }
    return json.decode(result.body);
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
