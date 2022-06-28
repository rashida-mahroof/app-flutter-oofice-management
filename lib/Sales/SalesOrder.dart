import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'package:untitled/Sales/SalesDetails.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'SalesModel.dart';
import 'package:untitled/Sales/Productdetails.dart';

class SalesOrderView extends StatefulWidget {
  const SalesOrderView({Key? key}) : super(key: key);

  @override
  State<SalesOrderView> createState() => _SalesOrderViewState();
}
late List<Sales> Data=[];

late List<Productdetails> Pdata=[];
Object _value = 1;
final fromdate = TextEditingController();
final todate = TextEditingController();
DateTime date1 = DateTime.now();
int cont = 5;
double TotlAmount=0;
String Date(dynamic user) {
  return user['Date'];
}

String Particulars(dynamic user) {
  return user['Particulars'];
}

String VoucherNo(dynamic user) {
  return user['VoucherNo'];
}

double NetAmount(dynamic user) {
  return user['NetAmount'];
}

class _SalesOrderViewState extends State<SalesOrderView> {
  @override


  static const int sortName = 0;

  bool isAscending = true;
  int sortType = sortName;
  Widget build(BuildContext context) {
    IntiaGetDepts();
    IntiaGetRoles('All');
    GetUsers('All', 'All');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sales'),
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
                  icon: const Icon(
                    Icons.home,
                    size: 25,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    //if(DeptList!.length>1)
                      ShowDept(),
                    //if(RoleList!.length>1)
                      ShowSingle(),
                    //if(UserList!.length>1)
                      ShowGroup(),
                  ],
                ),
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchSales(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    cont = snapshot.data.length;
                  }
                  return Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DecoratedBox(
                          decoration: const ShapeDecoration(
                            // color: Colors.teal.shade50,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.teal),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.teal,
                                    size: 20.09,
                                  ),
                                  isExpanded: true,
                                  value: _value,
                                  // dropdownColor: Colors.teal.shade50,
                                  elevation: 16,
                                  underline: const SizedBox(),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text(" Sales Type"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Sales Order"),
                                      value: 15,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Sales Invoice"),
                                      value: 9,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Sales Estimate"),
                                      value: 13,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Sales Quotation"),
                                      value: 17,
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      fetchSales();
                                    });
                                  },
                                  hint: const Text("Select Report")),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, left: 20, bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                      controller:
                                          fromdate, //editing controller of this TextField
                                      decoration: const InputDecoration(
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
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2022, 4, 1),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime.now());
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
                                      decoration: const InputDecoration(
                                          icon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.orange,
                                          ), //icon of text field
                                          labelText: "To Date" //label text of field
                                          ),
                                      readOnly:
                                          true, //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: date1,
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime.now());
                                        if (pickedDate != null) {
                                          //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          //formatted date output using intl package =>  2021-03-16
                                          //you can implement different kind of Date Format here according to your requirement

                                          setState(() {
                                            todate.text = formattedDate; //s
                                            //
                                            cont;
                                            fetchSales();
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
                        ),
                      ),
                      // if (snapshot.hasData && cont > 0)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Table(
                      //       border: TableBorder.all(
                      //           color: Colors.orange.shade400, width: 1),
                      //       children: [
                      //         TableRow(children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(
                      //               'SI No',
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(
                      //               'Date',
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(
                      //               'Voucher No',
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(
                      //               'Particulars',
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(
                      //               'Net Amount' + cont.toString(),
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //           ),
                      //         ]),
                      //         for (int i = 0; i < cont; i++)
                      //           TableRow(children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Center(
                      //                   child: Text(
                      //                 (i + 1).toString(),
                      //                 style: GoogleFonts.poppins(
                      //                     fontSize: 10, color: Colors.black87),
                      //               )),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.all(3),
                      //               child: Text(
                      //                   Date(snapshot.data[i]).toString(),
                      //                   style: GoogleFonts.poppins(
                      //                       fontSize: 10,
                      //                       color: Colors.black87)),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.all(8),
                      //               child: Center(
                      //                 child: Text(
                      //                     VoucherNo(snapshot.data[i])
                      //                         .toString(),
                      //                     style: GoogleFonts.poppins(
                      //                         fontSize: 10,
                      //                         color: Colors.black87)),
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.all(3),
                      //               child: Text(
                      //                   Particulars(snapshot.data[i])
                      //                       .toString(),
                      //                   style: GoogleFonts.poppins(
                      //                       fontSize: 10,
                      //                       color: Colors.black87)),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.all(3),
                      //               child: Text(
                      //                   NetAmount(snapshot.data[i]).toString(),
                      //                   style: GoogleFonts.poppins(
                      //                       fontSize: 10,
                      //                       color: Colors.black87)),
                      //             ),
                      //           ]),
                      //       ],
                      //     ),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child:


                        _getBodyWidget(),
                      ),
if(TotlAmount>0)
                      Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade500,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
                                  
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Total Amount:  ',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),
                                    Text(TotlAmount.toString(),style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                                  ],),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget _getBodyWidget() {
    return FutureBuilder<List<dynamic>>(
        future: fetchSales(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(Data.isNotEmpty)
          {
            return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 600,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: Data.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.yellow,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.red,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
      ),
      height: MediaQuery.of(context).size.height / 2,
    );
          }else {
            return const Text('');
          }
          });
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Ord No', 100),
      _getTitleItemWidget('Ord Date', 100),
      _getTitleItemWidget('Customer Name', 200),
      _getTitleItemWidget('Delivery Date', 100),
      _getTitleItemWidget('Total amnt', 100),
      _getTitleItemWidget('Status', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: Colors.orange.shade900,
      child: Text(label,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12)),
      width: width,
      height: 45,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.grey.shade200,
      child: Tooltip(
        message: 'Detailed',
        child: TextButton(
          onPressed: () {
            getDetails(Data[index].voucherNo.toString());
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => SalesDetails()));
          },
          child: Text(
            Data[index].voucherNo.toString(),
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
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(Data[index].date.toString(),
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)),
          width: 100,
          height: 40,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].particulars.toString(),
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)),
          width: 200,
          height: 40,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].deliveryDate.toString(),
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)),
          width: 100,
          height: 40,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(Data[index].netAmount.toString(),
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)),
          width: 100,
          height: 40,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Data[index].isDelivered!>0? Text('Delivered',
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)):Text('Not Delivered',
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11)),
          width: 100,
          height: 40,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Future<List<Sales>> fetchSales() async {
    final String apiUrl =
        'https://www.hokybo.com/TMS/api/sales/GetEmployeeSalesByID?UserID=' +
            selectedUserID.toString() +
            '&VoucherID=' +
            _value.toString() +
            '&Fromdate=' +
            fromdate.text +
            '&Todate=' +
            todate.text;
    var result = await http.get(Uri.parse(apiUrl));
    final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
    Data = parsed.map<Sales>((json) => Sales.fromJson(json)).toList();
    double ttamount=0;
    for(var c in Data)
    {
      ttamount+=c.netAmount;
    }
    setState(() {
      TotlAmount=ttamount;
    });
    return jsonDecode(result.body);
    
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

  //DropDowns

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
            dropdownSearchDecoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.orange,
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
              '&WCode=Sales'));
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
            dropdownSearchDecoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.home_work,
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
              '&WCode=Sales'));
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
          dropdownSearchDecoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.credit_card,
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
              '&WCode=Sales'));
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


  getDetails(String _vounumb)
  {
    List<Sales>detail=[];
    for(var e in Data)
    {
      if(e.voucherNo==_vounumb)
      {
        detail.add(e);
      }
    }

    if(detail.isNotEmpty)
    {
      fetchSalesProducts(detail[0].transmasterid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SalesDetails(
                    Obj: detail,
                    vcode: _vounumb,
                    UserName: selectedUser,
                    SalesType: _value,
                    PData: Pdata,
                  )));
    }

  }

  Future<List<Productdetails>> fetchSalesProducts(var _transid) async {
    
    final String apiUrl =
        'https://www.hokybo.com/TMS/api/sales/GetProductDetailsByVoucherNo?VoucherID='+_transid.toString();
    var result = await http.get(Uri.parse(apiUrl));
    final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
   setState(() {
     Pdata = parsed.map<Productdetails>((json) => Productdetails.fromJson(json)).toList();
   });
    return Pdata;
    
  }
}
