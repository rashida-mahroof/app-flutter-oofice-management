import 'dart:convert';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Followup/followup-list.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/home.dart';
import '../Model/users.dart';

final _formKey = GlobalKey<FormState>();

class UpdateFollowup extends StatefulWidget {
  const UpdateFollowup({Key? key}) : super(key: key);

  @override
  State<UpdateFollowup> createState() => _UpdateFollowupState();
}

class _UpdateFollowupState extends State<UpdateFollowup> {
  final _responseController = TextEditingController();
  final _noteController = TextEditingController();
  final _ProductsController = TextEditingController();
  final _commentController = TextEditingController();
  final _clsreasonController = TextEditingController();

  var radioButtonItem = '';
  int id = 1;
  Color bmColor = Colors.deepOrange;
  Color creColor = Colors.grey;
  Object prsType = 'Open';
  List<String> possiblity = [
    'HOT',
    'WARM',
    'COOL'
  ];
  int selectedIndex = 0;
  final nxtstpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Followup'),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Action done',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                      SizedBox(height: 3,),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange)
                        ),
                        child: CustomDropdown(
                          hintText: 'Select action',
                          items: ['Telecalling','Home visit','Mail','Quotation'],
                          controller: nxtstpController,
                          excludeSelected: false,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Response',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                      TextFormField(
                        controller: _responseController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange, width: 1),
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 1,
                      ),
                      SizedBox(height: 10,),
                      Text('Note',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                      TextFormField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange, width: 1),
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 1,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          CustomRadioButton(
                            elevation: 0,
                            absoluteZeroSpacing: false,
                            defaultSelected: 'Open',
                            unSelectedColor: Theme.of(context).canvasColor,
                            unSelectedBorderColor:Colors.orange.shade800,
                            buttonLables: [
                             'Open',
                              'Closed',
                              'Success'
                            ],
                            buttonValues: [
                              'Open',
                              'Closed',
                              'Success'
                            ],
                            buttonTextStyle: ButtonTextStyle(
                                selectedColor: Colors.white,
                                unSelectedColor: Colors.black54,
                                textStyle: TextStyle(fontSize: 13)),
                            radioButtonValue: (value) {
                              print(value);
                              setState((){
                                prsType = value!;
                              });
                            },
                            width: 90,
                            selectedColor: Colors.orange.shade800,
                            selectedBorderColor: Colors.grey.shade300,
                            padding: 5,
                            // enableShape: true,


                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ( prsType=='Success'|| prsType == 'Closed' )?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(prsType == 'Success')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 1,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Order';
                                            id = 1;
                                            print(radioButtonItem);
                                          });
                                        },
                                      ),
                                      Text(
                                          'Order',
                                          style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54)
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 2,
                                        groupValue: id,
                                        onChanged: (val) {
                                          setState(() {
                                            radioButtonItem = 'Estimate';
                                            id = 2;
                                            print(radioButtonItem);
                                          });
                                        },
                                      ),
                                      Text(
                                          'Estimate',
                                          style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text('Products',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                              TextFormField(
                                controller: _ProductsController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1),
                                  ),

                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 10,),
                              Text('Note',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                              TextFormField(
                                controller: _noteController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1),
                                  ),

                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 1,
                              ),
                              SizedBox(height: 10,),
                              Text('Comments',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                              TextFormField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1),
                                  ),

                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 1,
                              ),
                            ],
                          ),
if(prsType == 'Closed')
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Closing reason',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
      TextFormField(
        controller: _clsreasonController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                  color: Colors.orange, width: 1),
          ),

        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          } else {
            return null;
          }
        },
        maxLines: 1,
      ),
    ],
  ),


                        ],
                      ):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Possiblity',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                              Wrap(
                                spacing: 8,
                                alignment: WrapAlignment.center,
                                children: [
                                  spaceStatusRD(possiblity[0], 0),
                                  spaceStatusRD(possiblity[1], 1),
                                  spaceStatusRD(possiblity[2], 2),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next follow up date',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                    SizedBox(height: 3,),
                                    GestureDetector(
                                      onTap: () {
                                        _selectDateRU(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.deepOrange,
                                          border: Border.all(
                                              color: Colors.orange
                                          ),
                                          // borderRadius: BorderRadius
                                          //     .circular(6)
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
                                                    fontSize: 14,
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

                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next Step',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                    SizedBox(height: 3,),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.orange)
                                      ),
                                      child: CustomDropdown(
                                        hintText: 'Select next step',
                                        items: ['Telecalling','Home visit','Mail','Quotation'],
                                        controller: nxtstpController,
                                        excludeSelected: false,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(onPressed: (){
    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowupList()));
    }
                    },
                      style: ElevatedButton.styleFrom(primary: Colors.teal.shade800),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),)),
              ],
            ),
          )
        ],
      ),
    );
  }
  DateTime selectedDateRU = DateTime.now().add(Duration(days: 1));

  _selectDateRU(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDateRU,
        firstDate: DateTime.now().add(Duration(days: 1)),
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
  void changeIndex1(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  Widget spaceStatusRD(String txt, int index) {
    return OutlinedButton(
        onPressed: () => changeIndex1(index),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              color: selectedIndex == index ? Colors.deepOrange : Colors.grey,
              fontWeight: selectedIndex == index ? FontWeight.w500 : FontWeight
                  .w400
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

    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }
}


