import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Incentive/detail.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Incentive/modl.dart';
import 'package:untitled/Login/globals.dart' as globals;

class SummaryView extends StatefulWidget {
  const SummaryView({Key? key}) : super(key: key);

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

String Name(dynamic user) {
  return user['Name'];
}

String Date(dynamic user) {
  return user['Date'];
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
double _totIncentive=0;
double _totSales=0;
double _totCustomers=0;
final fromdate = TextEditingController();
final todate = TextEditingController();
DateTime date1 = DateTime.now();
int cont = 5;

class _SummaryViewState extends State<SummaryView> {

  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  // void initState() {
  //   super.initState();
  // }

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
        title: Text("Incentive"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [

                Column(
                  children: [
        //if(DeptList!.length>1)
          ShowDept(),
        //if(RoleList!.length>1)
    ShowSingle(),
    //if(UserList!.length>1)
    ShowGroup(),
                  ],
                ),
              FutureBuilder<List<dynamic>>(
                future: fetchincentive(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10)
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
                                          color: Colors.red,
                                        ), //icon of text field
                                        labelText:
                                            "From Date" //label text of field
                                        ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101));
                                      builder:
                                      (context, child) {
                                        return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor: Colors.orange,
                                              accentColor:
                                                  const Color(0xFF8CE7F1),
                                              colorScheme: ColorScheme.light(
                                                  primary:
                                                      const Color(0xFFFF7636)),
                                              buttonTheme: ButtonThemeData(
                                                  textTheme:
                                                      ButtonTextTheme.primary),
                                            ),
                                            child: child!);
                                      };
                                      if (pickedDate != null) {
                                        //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyy-MM-dd')
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
                                          color: Colors.redAccent,
                                        ), //icon of text field
                                        labelText: "To Date" //label text of field
                                        ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime.now());
                                      builder:
                                      (context, child) {
                                        return Theme(
                                            data: ThemeData.light().copyWith(
                                              primaryColor: Colors.orange,
                                              accentColor:
                                                  const Color(0xFF8CE7F1),
                                              colorScheme: ColorScheme.light(
                                                  primary:
                                                      const Color(0xFFFF7636)),
                                              buttonTheme: ButtonThemeData(
                                                  textTheme:
                                                      ButtonTextTheme.primary),
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
                                          cont = date2.difference(date1).inDays;
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
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'Rashida Mahroof - TTEA28',
                        //         style: GoogleFonts.poppins(
                        //             fontWeight: FontWeight.w600,
                        //             color: Colors.teal,
                        //             fontSize: 14),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        if (Data.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF0B765D),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          if(Data.isNotEmpty)
                                          
                                          Text(
                                            _totIncentive.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          if(Data.isEmpty)
                                            Text(
                                              '0',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Total  Incentive     ',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              // Icon(
                                              //   Icons.currency_rupee,
                                              //   color: Colors.white,
                                              //   size: 25,
                                              // ),
                                              if(Data.isNotEmpty)
                                                Text(
                                                  Data.length.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              if(Data.isEmpty)
                                                Text(
                                                  '0',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w700),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Total Customers ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 30),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.currency_rupee,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              if(Data.isNotEmpty)
                                              Text(
                                                _totSales.toStringAsFixed(2),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              if(Data.isEmpty)
                                              Text(
                                              '0',
                                              style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.w700),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Total Sales     ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 0,
                        // ),
                        _getBodyWidget(),
                        SizedBox(
                          height: 10,
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child: Column(
                        //     children: [
                        //       Card(
                        //         color: Colors.purple.shade100,
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 20, horizontal: 10),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         right: 6),
                        //                     child: Icon(
                        //                       Icons.account_box_rounded,
                        //                       color: Colors.purple,
                        //                     ),
                        //                   ),
                        //                   Text(
                        //                     'Total Customers',
                        //                     style: GoogleFonts.poppins(
                        //                         fontSize: 13,
                        //                         color: Colors.black54,
                        //                         fontWeight:
                        //                             FontWeight.w500),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.only(
                        //                     right: 10),
                        //                 child: Text(
                        //                   '5',
                        //                   style: GoogleFonts.poppins(
                        //                       fontSize: 14,
                        //                       color: Colors.black54,
                        //                       fontWeight: FontWeight.w600),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Card(
                        //         color: Colors.green.shade100,
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 20, horizontal: 10),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         right: 6),
                        //                     child: Icon(
                        //                       Icons.currency_rupee,
                        //                       color: Colors.green,
                        //                     ),
                        //                   ),
                        //                   Text(
                        //                     'Total Invoice',
                        //                     style: GoogleFonts.poppins(
                        //                         fontSize: 13,
                        //                         color: Colors.black54,
                        //                         fontWeight:
                        //                             FontWeight.w500),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Text(
                        //                 '7800/-',
                        //                 style: GoogleFonts.poppins(
                        //                     fontSize: 14,
                        //                     color: Colors.black54,
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Card(
                        //         color: Colors.red.shade100,
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 20, horizontal: 10),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         right: 6),
                        //                     child: Icon(
                        //                       Icons.check_circle,
                        //                       color: Colors.redAccent,
                        //                     ),
                        //                   ),
                        //                   Text(
                        //                     'Incentive ',
                        //                     style: GoogleFonts.poppins(
                        //                         fontSize: 13,
                        //                         color: Colors.black54,
                        //                         fontWeight:
                        //                             FontWeight.w500),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Text(
                        //                 '2300/-',
                        //                 style: GoogleFonts.poppins(
                        //                     fontSize: 14,
                        //                     color: Colors.black54,
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )

                        // if (snapshot.hasData)
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getBodyWidget() {
    return FutureBuilder<List<dynamic>>(
        future: fetchincentive(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 600,
                isFixedHeader: true,
                headerWidgets: _getTitleWidget(),
                leftSideItemBuilder: _generateFirstColumnRow,
                rightSideItemBuilder: _generateRightHandSideColumnRow,
                itemCount: snapshot.data.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.black54,
                  height: 1.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                verticalScrollbarStyle: const ScrollbarStyle(
                  thumbColor: Colors.yellow,
                  isAlwaysShown: true,
                  thickness: 4.0,
                  radius: Radius.circular(5.0),
                ),
                horizontalScrollbarStyle: const ScrollbarStyle(
                  isAlwaysShown: true,
                  thumbColor: Colors.redAccent,
                  thickness: 3.0,
                  radius: Radius.circular(5.0),
                ),
              ),
              height: MediaQuery.of(context).size.height / 1.8,
            );
          } else {
            return Text('');
          }
        });
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget('Invoice No', 100),
        onPressed: () {
          
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          // data1.sortName(isAscending);
          setState(() {});
        },
        child: _getTitleItemWidget('Invoice Date', 100),
      ),
      _getTitleItemWidget('Customer Name', 300),
      _getTitleItemWidget('Bill Amount', 100),
      _getTitleItemWidget('Inc. Amount', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.deepOrange,
        child: Text(label,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.white)),
        width: width,
        height: 43,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.grey.shade200,
      child: Tooltip(
        message: 'Detailed',
        child: TextButton(
          onPressed: () {
            String _pn = Data[index].voucherNo.toString();
            gotoDetails(_pn);
          },
          child: Text(
            Data[index].voucherNo!,
            // Data[index].empCode!,
            style: GoogleFonts.poppins(
                decoration: TextDecoration.underline,
                fontSize: 11,
                color: Colors.blue,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      width: 100,
      height: 40,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(Data[index].date!,
                  // Data[index].empName!,

                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.black54,
                  ))
            ],
          ),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].partyName!,
              // Data[index].totalSales!,

              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 300,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].invoiceAmnt!,
              // Data[index].salesReturn!,

              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].incentive!,
              // Data[index].discount!,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.black54,
              )),
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
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
            mode: Mode.DIALOG,
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
              '&WCode=Incentive'));
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
            popupBackgroundColor: Colors.grey.shade300,
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.home_work,
                  color: Colors.grey,
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
              '&WCode=Incentive'));
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
          popupBackgroundColor: Colors.grey.shade300,
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
              '&WCode=Incentive'));
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

late List<Incentives> Data=[];
  Future<List<Incentives>> fetchincentive() async {
  
    final String apiUrl =
        'https://www.hokybo.com/TMS/api/Incentive/GetAllIcentives?UserID=' +
            selectedUserID.toString() +
            '&Fromdate=' +
            fromdate.text +
            '&Todate=' +
            todate.text;
    var result = await http.get(Uri.parse(apiUrl));
    final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
    Data = parsed.map<Incentives>((json) => Incentives.fromJson(json)).toList();
   
    if(Data.isNotEmpty)
    {
      _totIncentive=0;
      _totSales=0;
      for(var e in Data)
      {
         _totIncentive+=double.parse(e.incentive.toString());
        _totSales+=double.parse(e.invoiceAmnt.toString());
      }
    }
    return parsed.map<Incentives>((json) => Incentives.fromJson(json)).toList();
  }

  var detaileddata;
  gotoDetails(String _pname) async {
    final String apiUrl =
        'https://www.hokybo.com/TMS/api/Incentive/GetAllIcentivesDetails?UserID=' +
            selectedUserID.toString() +
            '&Fromdate=' +
            fromdate.text +
            '&Todate=' +
            todate.text+'&Vno='+_pname;
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
    
      detaileddata = json.decode(result.body);
      

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IncentiveDetailView(
                    Obj: detaileddata,
                    Pname: _pname,
                    UserName:selectedUser
                  )));
    }
  }
}
