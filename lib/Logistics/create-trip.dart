import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Logistics/trips-list.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;

class CreateTrip extends StatefulWidget {
  const CreateTrip({Key? key}) : super(key: key);

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

final _formKey = GlobalKey<FormState>();
// late List<String>? Vehi = [];
// late List<String>? Driv = [];
// late List<String>? RouteU = [];
// late List<String>? RouteD = [];
class _CreateTripState extends State<CreateTrip> {

  List<String> spaceRU = [
    'Full',
    '100% vacant',
    '75% vacant',
    '50% vacant',
    '25% vacant'
  ];
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  Object _vehNo = 1;
  Object _driver = 1;
  Object _routeUpValue = 1;
  Object _routeDwnValue = 1;
String driver="";
  String vehicle="";
  String routeUpValue="";
  String routeDwnValue="";
  @override
  void initState() {
    // TODO: implement initState
    // IntiaGetVeh();
    // IntiaGetDri();
    // IntiaGetRoute();
    super.initState();

  }
  Widget build(BuildContext context) {
    // IntiaGetVeh();
    // IntiaGetDri();
    // IntiaGetRoute();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Trip'),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: DropdownButton(
                                      value: _vehNo,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Vehicle Number",
                                            style: TextStyle(
                                                color: Colors.white54),),
                                          value: 1,
                                        ),
                                      for(int i=0;i<Vehi!.length;i++)
                                                  DropdownMenuItem(
                                          child: Text(Vehi![i].toString()),
                                          value: i+2,
                                        ),

                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _vehNo = value!;
                                          vehicle=Vehi![int.parse(value.toString())-2];
                                        });
                                      },
                                      icon: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(Icons.directions_car)),
                                      iconEnabledColor: Colors.white,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      dropdownColor: Colors.teal,
                                      underline: Container(),
                                      isExpanded: true,
                                    )))),
                            SizedBox(width: 10,),
                            Expanded(child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade700,
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: DropdownButton(
                                      value: _driver,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Driver",
                                              style: TextStyle(
                                                  color: Colors.white54)),
                                          value: 1,
                                        ),
                                        for(int i=0;i<Driv!.length;i++)
                                          DropdownMenuItem(
                                            child: Text(Driv![i].toString()),
                                            value: i+2,
                                          ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _driver = value!;
                                          driver=Driv![int.parse(value.toString())-2];
                                        });
                                      },
                                      icon: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(Icons.account_circle)),
                                      iconEnabledColor: Colors.white,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      dropdownColor: Colors.orange.shade700,

                                      underline: Container(),
                                      isExpanded: true,
                                    ))))
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
                                  border:
                                  Border.all(color: Colors.orange.shade200),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 6),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius: BorderRadius.circular(
                                                6)
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButton(

                                                underline: Container(),
                                                value: _routeUpValue,
                                                icon: const Icon(
                                                    Icons.alt_route),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black87),

                                                onChanged: (value) {
                                                  setState(() {
                                                    _routeUpValue = value!;
                                                    routeUpValue=RouteU![int.parse(value.toString())-2];
                                                  });
                                                },

                                                items: [
                                                  // 'Select Route', 'CKL - CPTR - CTTP - TVM - CLT', 'CLT - CTTP - PLT - CPTR - CKL', 'CKL - CPTR - CTTP - TVM - CLT'
                                                  DropdownMenuItem(
                                                    child: Text('Select Route'),
                                                    value: 1,
                                                  ),
                                                  for(int i=0;i<RouteU!.length;i++)
                                                    DropdownMenuItem(
                                                      child: Text(RouteU![i].toString()),
                                                      value: i+2,
                                                    ),
                                                ]


                                            )

                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Text(
                                                  'Start date & time :   ',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _selectDateRU(context);
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
                                                          _selectDateRU(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.calendar_today,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        )),
                                                    Text(
                                                      "${selectedDateRU
                                                          .day}/${selectedDateRU
                                                          .month}/${selectedDateRU
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
                                          GestureDetector(
                                            onTap: () {
                                              _selectTimeRU(context);
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
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          _selectTimeRU(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.access_time,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        )),
                                                    Text(
                                                      " ${selectedTimeRU
                                                          .hour}:${selectedTimeRU
                                                          .minute} ",
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
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              Text(
                                                'Space status (Percentage of vacancy) :   ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black38),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        spacing: 8,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          spaceStatus(spaceRU[0], 0),
                                          spaceStatus(spaceRU[1], 1),
                                          spaceStatus(spaceRU[2], 2),
                                          spaceStatus(spaceRU[3], 3),
                                          spaceStatus(spaceRU[4], 4),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            Positioned(
                              left: 5,
                              top: -4,
                              child: Container(
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'Route Up',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.orange.shade500),
                                    ),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.orange.shade200),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 6),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius: BorderRadius.circular(
                                                6)
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButton(
                                                underline: Container(),
                                                value: _routeDwnValue,
                                                icon: const Icon(Icons.route),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black87),

                                                onChanged: (value) {
                                                  setState(() {
                                                    _routeDwnValue = value!;
                                                    routeDwnValue=RouteD![int.parse(value.toString())-2];
                                                  });
                                                },
                                                items:
                                                [

                                                  DropdownMenuItem(
                                                    child: Text('Select Route'),
                                                    value: 1,
                                                  ),
                                                  for(int i=0;i<RouteD!.length;i++)
                                                    DropdownMenuItem(
                                                      child: Text(RouteD![i].toString()),
                                                      value: i+2,
                                                    ),
                                                ]
                                            )

                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Text(
                                                  'Start date & time :   ',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _selectDateRD(context);
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
                                                          _selectDateRD(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.calendar_today,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        )),
                                                    Text(
                                                      "${selectedDateRD
                                                          .day}/${selectedDateRD
                                                          .month}/${selectedDateRD
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
                                          GestureDetector(
                                            onTap: () {
                                              _selectTimeRD(context);
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
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          _selectTimeRD(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.access_time,
                                                          color: Colors.orange,
                                                          size: 30,
                                                        )),
                                                    Text(
                                                      " ${selectedTimeRD
                                                          .hour}:${selectedTimeRD
                                                          .minute} ",
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
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              Text(
                                                'Space status (Percentage of vacancy) :   ',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black38),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        spacing: 8,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          spaceStatusRD(spaceRU[0], 0),
                                          spaceStatusRD(spaceRU[1], 1),
                                          spaceStatusRD(spaceRU[2], 2),
                                          spaceStatusRD(spaceRU[3], 3),
                                          spaceStatusRD(spaceRU[4], 4),
                                        ],
                                      ),

                                    ],
                                  )),
                            ),
                            Positioned(
                              left: 5,
                              top: -4,
                              child: Container(
                                  color: Colors.grey[50],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'Route Down',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.orange.shade500),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3, horizontal: 3),
                    child: ElevatedButton(
                      onPressed: () {

                          var Posturi =
                          Uri.parse('https://www.hokybo.com/tms/api/Trip/PostCreate');
                          var request = http.MultipartRequest("POST", Posturi);
                          request.fields['VehicleNo'] = vehicle.toString();
                          request.fields['DriverNo'] = driver.toString();
                          request.fields['UserID'] = globals.login_id.toString();
                          request.fields['Up_RouteNo'] = routeUpValue.toString();
                          request.fields['Down_RouteNo'] = routeDwnValue.toString();
                          request.fields['Up_date'] = selectedDateRU.toString();
                          request.fields['Down_date'] = selectedDateRD.toString();
                          request.fields['Up_time'] = (selectedTimeRU.hour.toString() +
                              ":" +selectedTimeRU.minute.toString()+selectedTimeRU.period.toString()).toString();
                          request.fields['Down_time'] = (selectedTimeRD.hour.toString() +
                              ":" +selectedTimeRD.minute.toString()+selectedTimeRD.period.toString()).toString();
                          request.fields['Up_Space'] = spaceRU[selectedIndex].toString();
                          request.fields['Down_Space'] = spaceRU[selectedIndex1].toString();

                        request.send().then((response) {
                        if (response.statusCode == 201) {
                        Fluttertoast.showToast(
                        msg: 'Trip Created',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                        Navigator.pushReplacement(
                        context,
                         MaterialPageRoute(builder: (context) =>
                        const TripsList()));
                        } else {
                        Fluttertoast.showToast(
                        msg: response.statusCode.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white);
                        }

                        });



                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Create Trip',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget spaceStatus(String txt, int index) {
    return OutlinedButton(
        onPressed: () => changeIndex(index),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              color: selectedIndex == index ? Colors.deepOrange : Colors.grey,
              fontWeight: selectedIndex == index ? FontWeight.w500 : FontWeight
                  .w400
          ),
        ));
  }

  void changeIndex1(int index) {
    setState(() {
      selectedIndex1 = index;
    });
  }

  Widget spaceStatusRD(String txt, int index) {
    return OutlinedButton(
        onPressed: () => changeIndex1(index),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              color: selectedIndex1 == index ? Colors.deepOrange : Colors.grey,
              fontWeight: selectedIndex1 == index ? FontWeight.w500 : FontWeight
                  .w400
          ),
        ));
  }

  TimeOfDay selectedTimeRU = TimeOfDay.now();
  DateTime selectedDateRU = DateTime.now();

  _selectDateRU(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDateRU,
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
    if (selected != null && selected != selectedDateRU)
      setState(() {
        selectedDateRU = selected;
      });
  }

  _selectTimeRU(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTimeRU,
        initialEntryMode: TimePickerEntryMode.dial,
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
    if (timeOfDay != null && timeOfDay != selectedTimeRU) {
      setState(() {
        selectedTimeRU = timeOfDay;
      });
    }
  }

  TimeOfDay selectedTimeRD = TimeOfDay.now();
  DateTime selectedDateRD = DateTime.now();

  _selectDateRD(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDateRD,
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
    if (selected != null && selected != selectedDateRD)
      setState(() {
        selectedDateRD = selected;
      });
  }

  _selectTimeRD(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTimeRD,
        initialEntryMode: TimePickerEntryMode.dial,
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
    if (timeOfDay != null && timeOfDay != selectedTimeRD) {
      setState(() {
        selectedTimeRD = timeOfDay;
      });
    }
  }

}
