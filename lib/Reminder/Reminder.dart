import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:untitled/Login/globals.dart' as globals;
import '../Notification.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

final subject = TextEditingController();
final content = TextEditingController();
final editsubController = TextEditingController();
final editContController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _editformKey = GlobalKey<FormState>();
String dt = "";
int reminID = 0;

class _ReminderListState extends State<ReminderList> {
  int _reminID(dynamic user) {
    return user['ReminderId'];
  }

  String _subject(dynamic user) {
    return user['Subject'];
  }

  String _content(dynamic user) {
    return user['Contents'];
  }

  String _date(dynamic user) {
    return user['Date'];
  }

  String _time(dynamic user) {
    return user['Time'];
  }

  int _userid(dynamic user) {
    return user['UserID'];
  }

  String _status(dynamic user) {
    return user['Status'];
  }

  int _count(dynamic user) {
    return user['ReminderCount'];
  }

  Future<List<dynamic>> fetchReminder(int userid) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Reminder/GetAllDetails?userId=" +
            userid.toString();

    var result = await http.get(Uri.parse(apiUrl));

    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Reminders"),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: fetchReminder(globals.login_id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ExpansionTile(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        _content(snapshot.data[index]),
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          TimeOfDay _startTime = TimeOfDay(
                                              hour: int.parse(
                                                  _time(snapshot.data[index])
                                                      .split(":")[0]),
                                              minute: int.parse(
                                                  _time(snapshot.data[index])
                                                      .split(":")[1]));
                                          DateTime datt = DateTime.parse(
                                              _date(snapshot.data[index]));
                                          editsubController.text =
                                              _subject(snapshot.data[index]);
                                          editContController.text =
                                              _content(snapshot.data[index]);
                                          reminID =
                                              _reminID(snapshot.data[index]);
                                          dt = _date(snapshot.data[index]);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              DateTime selectedDate = datt;
                                              TimeOfDay selectedTime =
                                                  _startTime;
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    content: Stack(
                                                      clipBehavior: Clip.none,
                                                      children: <Widget>[
                                                        Positioned(
                                                          right: -50.0,
                                                          top: -50.0,
                                                          child: InkResponse(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: CircleAvatar(
                                                              child: Icon(
                                                                  Icons.close),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 500,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 10),
                                                              child: Column(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 10),
                                                                            child:
                                                                                Form(
                                                                              key: _editformKey,
                                                                              child: TextFormField(
                                                                                decoration: InputDecoration(
                                                                                  labelText: "Subject",
                                                                                  labelStyle: GoogleFonts.poppins(color: Colors.black54),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.orange),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.orange, width: 2),
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
                                                                                controller: editsubController,
                                                                                maxLines: null,
                                                                                maxLength: 50,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 10),
                                                                            child:
                                                                                TextFormField(
                                                                              decoration: InputDecoration(
                                                                                  prefixIcon: Icon(
                                                                                    Icons.notes,
                                                                                    color: Colors.orange,
                                                                                  ),
                                                                                  labelText: "Description",
                                                                                  labelStyle: GoogleFonts.poppins(color: Colors.black54),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.orange),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.orange, width: 2),
                                                                                  ),
                                                                                  border: OutlineInputBorder()),
                                                                              controller: editContController,
                                                                              maxLines: 3,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 10),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Column(
                                                                                  children: [
                                                                                    Text(
                                                                                      'Remind Me on : ',
                                                                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black38),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () async {
                                                                                    // _selectTime(context);
                                                                                    final TimeOfDay? timeOfDay = await showTimePicker(
                                                                                      context: context,
                                                                                      initialTime: selectedTime,
                                                                                      initialEntryMode: TimePickerEntryMode.dial,
                                                                                    );
                                                                                    if (timeOfDay != null && timeOfDay != selectedTime) {
                                                                                      setState(() {
                                                                                        selectedTime = timeOfDay;
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.access_time,
                                                                                    color: Colors.orange,
                                                                                    size: 30,
                                                                                  )),
                                                                              Text(
                                                                                " ${selectedTime.hour}:${selectedTime.minute} ",
                                                                                style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              IconButton(
                                                                                  onPressed: () async {
                                                                                    final DateTime? selected = await showDatePicker(
                                                                                      context: context,
                                                                                      initialDate: selectedDate,
                                                                                      firstDate: DateTime.now(),
                                                                                      lastDate: DateTime(2025),
                                                                                    );
                                                                                    if (selected != null && selected != selectedDate) {
                                                                                      setState(() {
                                                                                        selectedDate = selected;
                                                                                      });
                                                                                    }
                                                                                    // _selectDate(context);
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.calendar_today,
                                                                                    color: Colors.orange,
                                                                                    size: 30,
                                                                                  )),
                                                                              Text(
                                                                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                                                                style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (_editformKey.currentState!.validate()) {
                                                                              var Posturi = Uri.parse('https://www.hokybo.com/tms/api/Reminder/PostEdit');
                                                                              var request = http.MultipartRequest("POST", Posturi);
                                                                              request.fields['Subject'] = editsubController.text;
                                                                              request.fields['Contents'] = editContController.text;
                                                                              request.fields['UserID'] = globals.login_id.toString();
                                                                              request.fields['Status'] = "Active";
                                                                              request.fields['ReminderID'] = reminID.toString();
                                                                              request.fields['Date'] = selectedDate.toString();
                                                                              request.fields['Time'] = (selectedTime.hour.toString() + ":" + selectedTime.minute.toString()).toString();

                                                                              request.send().then((response) {
                                                                                if (response.statusCode == 201) {
                                                                                  Fluttertoast.showToast(msg: 'Sent Successfully', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);

                                                                                  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => ReminderList()));
                                                                                } else {
                                                                                  Fluttertoast.showToast(msg: 'Required all fields', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
                                                                                }
                                                                              });
                                                                            }
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(primary: Colors.orange.shade700),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 8),
                                                                            child:
                                                                                Text(
                                                                              'Set Reminder',
                                                                              style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
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
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) {
                                          //       return AlertDialog(
                                          //         content: Stack(
                                          //           overflow: Overflow.visible,
                                          //           children: <Widget>[
                                          //             Positioned(
                                          //               right: -50.0,
                                          //               top: -50.0,
                                          //               child: InkResponse(
                                          //                 onTap: () {
                                          //                   Navigator.of(
                                          //                           context)
                                          //                       .pop();
                                          //                 },
                                          //                 child: CircleAvatar(
                                          //                   child: Icon(
                                          //                       Icons.close),
                                          //                   backgroundColor:
                                          //                       Colors.red,
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //             Container(
                                          //               height: 500,
                                          //               child:
                                          //                   SingleChildScrollView(
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       const EdgeInsets
                                          //                               .symmetric(
                                          //                           horizontal:
                                          //                               15,
                                          //                           vertical:
                                          //                               10),
                                          //                   child: Column(
                                          //                     children: [
                                          //                       Column(
                                          //                         children: [
                                          //                           Column(
                                          //                             children: [
                                          //                               Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.symmetric(vertical: 10),
                                          //                                 child:
                                          //                                     Form(
                                          //                                   key:
                                          //                                       _editformKey,
                                          //                                   child:
                                          //                                       TextFormField(
                                          //                                     decoration: InputDecoration(
                                          //                                       labelText: "Subject",
                                          //                                       labelStyle: GoogleFonts.poppins(color: Colors.black54),
                                          //                                       enabledBorder: OutlineInputBorder(
                                          //                                         borderSide: BorderSide(color: Colors.orange),
                                          //                                       ),
                                          //                                       focusedBorder: OutlineInputBorder(
                                          //                                         borderSide: BorderSide(color: Colors.orange, width: 2),
                                          //                                       ),
                                          //                                       prefixIcon: Icon(
                                          //                                         Icons.sticky_note_2,
                                          //                                         color: Colors.orange,
                                          //                                       ),
                                          //                                     ),
                                          //                                     validator: (value) {
                                          //                                       if (value == null || value.isEmpty) {
                                          //                                         return 'Subject is required';
                                          //                                       }
                                          //                                     },
                                          //                                     controller: editsubController,
                                          //                                     maxLines: null,
                                          //                                     maxLength: 50,
                                          //                                   ),
                                          //                                 ),
                                          //                               ),
                                          //                               Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.symmetric(vertical: 10),
                                          //                                 child:
                                          //                                     TextFormField(
                                          //                                   decoration: InputDecoration(
                                          //                                       prefixIcon: Icon(
                                          //                                         Icons.notes,
                                          //                                         color: Colors.orange,
                                          //                                       ),
                                          //                                       labelText: "Description",
                                          //                                       labelStyle: GoogleFonts.poppins(color: Colors.black54),
                                          //                                       enabledBorder: OutlineInputBorder(
                                          //                                         borderSide: BorderSide(color: Colors.orange),
                                          //                                       ),
                                          //                                       focusedBorder: OutlineInputBorder(
                                          //                                         borderSide: BorderSide(color: Colors.orange, width: 2),
                                          //                                       ),
                                          //                                       border: OutlineInputBorder()),
                                          //                                   controller:
                                          //                                       editContController,
                                          //                                   maxLines:
                                          //                                       3,
                                          //                                 ),
                                          //                               ),
                                          //                               Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.symmetric(vertical: 10),
                                          //                                 child:
                                          //                                     Row(
                                          //                                   mainAxisAlignment:
                                          //                                       MainAxisAlignment.center,
                                          //                                   children: <Widget>[
                                          //                                     Column(
                                          //                                       children: [
                                          //                                         Text(
                                          //                                           'Remind Me on : ',
                                          //                                           style: GoogleFonts.poppins(fontSize: 12, color: Colors.black38),
                                          //                                         ),
                                          //                                       ],
                                          //                                     ),
                                          //                                   ],
                                          //                                 ),
                                          //                               ),
                                          //                               Row(
                                          //                                 mainAxisAlignment:
                                          //                                     MainAxisAlignment.center,
                                          //                                 children: [
                                          //                                   IconButton(
                                          //                                       onPressed: () {
                                          //                                         _selectTime(context);
                                          //                                       },
                                          //                                       icon: Icon(
                                          //                                         Icons.access_time,
                                          //                                         color: Colors.orange,
                                          //                                         size: 30,
                                          //                                       )),
                                          //                                   Text(
                                          //                                     " ${selectedTime.hour}:${selectedTime.minute} ",
                                          //                                     style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w500),
                                          //                                   ),
                                          //                                 ],
                                          //                               ),
                                          //                               Row(
                                          //                                 mainAxisAlignment:
                                          //                                     MainAxisAlignment.spaceBetween,
                                          //                                 children: [
                                          //                                   Row(
                                          //                                     mainAxisAlignment: MainAxisAlignment.center,
                                          //                                     children: [
                                          //                                       IconButton(
                                          //                                           onPressed: () {
                                          //                                             _selectEditDate(context);
                                          //                                           },
                                          //                                           icon: Icon(
                                          //                                             Icons.calendar_today,
                                          //                                             color: Colors.orange,
                                          //                                             size: 30,
                                          //                                           )),
                                          //                                       Text(
                                          //                                         DateFormat.yMMMEd().format(DateTime.parse(dt)).toString(),
                                          //                                         style: GoogleFonts.poppins(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w500),
                                          //                                       ),
                                          //                                     ],
                                          //                                   ),
                                          //                                 ],
                                          //                               ),
                                          //                             ],
                                          //                           ),
                                          //                         ],
                                          //                       ),
                                          //                       SizedBox(
                                          //                         height: 10,
                                          //                       ),
                                          //                       Row(
                                          //                         children: [
                                          //                           Expanded(
                                          //                             child:
                                          //                                 ElevatedButton(
                                          //                               onPressed:
                                          //                                   () async {
                                          //                                 if (_editformKey
                                          //                                     .currentState!
                                          //                                     .validate()) {
                                          //                                   var Posturi =
                                          //                                       Uri.parse('https://www.hokybo.com/tms/api/Reminder/PostEdit');
                                          //                                   var request =
                                          //                                       http.MultipartRequest("POST", Posturi);
                                          //                                   request.fields['Subject'] =
                                          //                                       editsubController.text;
                                          //                                   request.fields['Contents'] =
                                          //                                       editContController.text;
                                          //                                   request.fields['UserID'] =
                                          //                                       globals.login_id.toString();
                                          //                                   request.fields['Status'] =
                                          //                                       "Active";
                                          //                                   request.fields['ReminderID'] =
                                          //                                       reminID.toString();
                                          //                                   request.fields['Date'] =
                                          //                                       selectedDate.toString();
                                          //                                   request.fields['Time'] =
                                          //                                       (selectedTime.hour.toString() + ":" + selectedTime.minute.toString()).toString();
                                          //
                                          //                                   request.send().then((response) {
                                          //                                     if (response.statusCode == 201) {
                                          //                                       Fluttertoast.showToast(msg: 'Sent Successfully', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);
                                          //
                                          //                                       Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => ReminderList()));
                                          //                                     } else {
                                          //                                       Fluttertoast.showToast(msg: 'Required all fields', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
                                          //                                     }
                                          //                                   });
                                          //                                 }
                                          //                               },
                                          //                               style: ElevatedButton.styleFrom(
                                          //                                   primary:
                                          //                                       Colors.orange.shade700),
                                          //                               child:
                                          //                                   Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.symmetric(vertical: 8),
                                          //                                 child:
                                          //                                     Text(
                                          //                                   'Set Reminder',
                                          //                                   style: GoogleFonts.poppins(
                                          //                                       fontSize: 15,
                                          //                                       color: Colors.white,
                                          //                                       fontWeight: FontWeight.w600),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           ),
                                          //                         ],
                                          //                       ),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       );
                                          //     });
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5),
                                              child: Icon(Icons.edit,size: 18),
                                            ),
                                            Text("Edit"),
                                          ],
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              // title: const Text('AlertDialog Title'),
                                              content: const Text(
                                                  'Do You want to delete this Reminder ?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      DeleteReminder(_reminID(
                                                          snapshot
                                                              .data[index])),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5),
                                              child: Icon(Icons.delete,size: 18,color: Colors.red,),
                                            ),
                                            Text('Delete',style: GoogleFonts.poppins(color: Colors.red),),
                                          ],
                                        )),
                                  ])
                            ],
                          )
                        ],
                        title: Text(
                          _subject(snapshot.data[index]),
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Colors.orange.shade700,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMEd()
                                          .format(DateTime.parse(
                                              _date(snapshot.data[index])))
                                          .toString() +
                                      ",  " +
                                      _time(snapshot.data[index]),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_down)),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade700,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              DateTime selectedDate = DateTime.now();
              TimeOfDay selectedTime = TimeOfDay.now();
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -50.0,
                          top: -50.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          height: 450,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "Subject",
                                              labelStyle: GoogleFonts.poppins(
                                                  color: Colors.black54),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange,
                                                    width: 2),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.sticky_note_2,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Subject is required';
                                              }
                                            },
                                            controller: subject,
                                            maxLines: null,
                                            maxLength: 50,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.notes,
                                                color: Colors.orange,
                                              ),
                                              labelText: "Description",
                                              labelStyle: GoogleFonts.poppins(
                                                  color: Colors.black54),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange,
                                                    width: 2),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Text(
                                                  'Remind Me on : ',
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    final DateTime? selected =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate: selectedDate,
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2025),
                                                    );
                                                    if (selected != null &&
                                                        selected !=
                                                            selectedDate) {
                                                      setState(() {
                                                        selectedDate = selected;
                                                      });
                                                    }
                                                    // _selectDate(context);
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    // _selectTime(context);
                                                    final TimeOfDay? timeOfDay =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: selectedTime,
                                                      initialEntryMode:
                                                          TimePickerEntryMode
                                                              .dial,
                                                    );
                                                    if (timeOfDay != null &&
                                                        timeOfDay !=
                                                            selectedTime) {
                                                      setState(() {
                                                        selectedTime =
                                                            timeOfDay;
                                                      });
                                                    }
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              var Posturi = Uri.parse(
                                                  'https://www.hokybo.com/tms/api/Reminder/PostCreate');
                                              var request =
                                                  http.MultipartRequest(
                                                      "POST", Posturi);
                                              request.fields['Subject'] =
                                                  subject.text;
                                              request.fields['Contents'] =
                                                  content.text;
                                              request.fields['UserID'] =
                                                  globals.login_id.toString();
                                              request.fields['Status'] =
                                                  "Active";
                                              request.fields['Date'] =
                                                  selectedDate.toString();
                                              request.fields['Time'] =
                                                  (selectedTime
                                                              .hour
                                                              .toString() +
                                                          ":" +
                                                          selectedTime.minute
                                                              .toString())
                                                      .toString();
                                              request.send().then((response) {
                                                if (response.statusCode ==
                                                    201) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Created Successfully',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.green,
                                                      textColor: Colors.white);

                                                  Navigator.pushReplacement(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              ReminderList()));
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: 'Error Occured',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                }
                                              });
                                            }
                                            sendNotification(
                                                subject.text, content.text);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange.shade700),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              'Set Reminder',
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
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime editselectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      this.setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
  // void itemNavigate() {
  //   Navigator.push(
  //     context,
  //     PageTransition(
  //       type: PageTransitionType.rightToLeft,
  //       child: const ReminderDetailsView(),
  //     ),
  //   );
  // }

  _selectEditDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: editselectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != editselectedDate) {
      setState(() {
        editselectedDate = selected;
        dt = editselectedDate.toString();
      });
    }
  }

  DeleteReminder(int reminderID) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Reminder/DeleteRemin?ReminderID=" +
            reminderID.toString();
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
              builder: (BuildContext context) => ReminderList()));
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
}
