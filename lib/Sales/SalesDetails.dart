import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Sales/Productdetails.dart';
import 'package:untitled/Sales/SalesModel.dart';
import 'package:untitled/Sales/SalesOrder.dart';

import '../Login/home.dart';
import '../Model/users.dart';

class SalesDetails extends StatefulWidget {
  final List<Sales>Obj;
  final String vcode;
  final String UserName;
  final Object SalesType;
  final List<Productdetails>PData;
  
  const SalesDetails({Key? key, required this.Obj, required this.vcode, required this.UserName, required this.SalesType, required this.PData}) : super(key: key);

  @override
  State<SalesDetails> createState() => _SalesDetailsState();
}

class _SalesDetailsState extends State<SalesDetails> {
late List<Productdetails> Data=[];

 
  

  @override
// void initState() {
//     // TODO: implement initState
//     super.initState();
//     // fetchSalesProducts();
//   }
  Widget build(BuildContext context) {
    // fetchSalesProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Order No: '+widget.vcode),
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
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Sold By: ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black26,
                            fontSize: 12),
                      ),
                      Text(
                        widget.UserName,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade700,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                Card(
                  shape: Border(left: BorderSide(color:Colors.lightBlue

                      , width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.hourglass_bottom, color: Colors.lightBlue),
                            ),
                            Text(
                              'Status',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            widget.Obj[0].isDelivered!>0?
                            Text(
                              'Delivered',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ):Text(
                              'Not Delivered',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: Border(left: BorderSide(color:Colors.pinkAccent

                      , width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.date_range_outlined, color: Colors.pinkAccent),
                            ),
                            Text(
                              'Order Date',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.Obj[0].orderdate!,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: Border(left: BorderSide(color: Colors.lightGreen, width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(Icons.account_circle_outlined, color: Colors.lightGreen),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Text(
                                      'Customer Name',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(widget.Obj[0].particulars!,
                                  overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

if(widget.SalesType==15)
                Card(
                  shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.timelapse, color: Colors.red),
                            ),
                            Text(
                              'Delivery date & Time',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.Obj[0].deliverytime!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.Obj[0].deliveryDate!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: Border(
                            left:
                            BorderSide(color: Color(0xFF13989C), width: 5)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Color(0xFF939EFF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 30),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Icon(Icons.my_location_rounded,
                                          color: Colors.teal),
                                    ),
                                    Text(
                                      'Delivery Address',
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.Obj[0].deliveryAddress!,
                                  // textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  shape:
                      Border(left: BorderSide(color: Colors.purple, width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.currency_rupee,
                                  color: Colors.purple),
                            ),
                            Text(
                              'Total Amount',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          widget.Obj[0].netAmount.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape:
                      Border(left: BorderSide(color: Colors.green, width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.check_box, color: Colors.green),
                            ),
                            Text(
                              'Paid Amount',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          widget.Obj[0].paidAmount.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: Border(
                      left: BorderSide(color:  Color(0xFF0039D7), width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.handshake,
                                  color:  Color(0xFF0039D7)),
                            ),
                            Text(
                              'Balance',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          widget.Obj[0].balanceAmount.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: Border(
                      left:
                          BorderSide(color: Colors.yellow.shade900, width: 5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.comment,
                                  color: Colors.yellow.shade900),
                            ),
                            Text(
                              'Comments',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.Obj[0].remarks!,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: Border(
                      left:
                      BorderSide(color: Color(0xFF71412A), width: 5)),
                  child: ExpansionTile(

                      title: Row(
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.chair,color: Color(0xFF71412A)),
                      ),
                      Text('Products',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.grey),),
                    ],
                  ),
                    children: <Widget>[
                      for(int i=0;i<Pdata.length;i++)
                      
                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black26,size: 15,),
                        //   trailing: Icon(Icons.done,color: Colors.black26,size: 15,),
                        title: Wrap(
                            spacing: 15,
                            children: [
                            Text(Pdata[i].productCode!+'('+Pdata[i].qty.toString()+')',style: GoogleFonts.poppins(fontSize: 13,color: Colors.black45,fontWeight: FontWeight.w500),),
                            Text(Pdata[i].rate.toString(),style: GoogleFonts.poppins(fontSize: 13,color: Colors.black45,fontWeight: FontWeight.w500),),
                            Text('From :'+Pdata[i].branchCode!,style: GoogleFonts.poppins(fontSize: 13,color: Colors.black45,fontWeight: FontWeight.w500),),
                          ],),
                        subtitle: Wrap(
                          spacing: 15,
                          children: [
                            Text('MRP:'+Pdata[i].mrp.toString(),style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w400),),
                            Text('Discount:'+Pdata[i].discRate.toString(),style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w400),),
                            Text('Discount %:'+Pdata[i].discPerc.toString()+'%',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w400),),
                            Text('Cloth Number:'+Pdata[i].clothNumber!,style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),

                    ],
                  ),
                )
               

              ],
            ),
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
    print(json1);
    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }


  // Future<List<Productdetails>> fetchSalesProducts() async {
    
  //   final String apiUrl =
  //       'https://www.hokybo.com/TMS/api/sales/GetProductDetailsByVoucherNo?VoucherID='+widget.Obj[0].transmasterid;
  //   var result = await http.get(Uri.parse(apiUrl));
  //   final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
  //  setState(() {
  //    Data = parsed.map<Productdetails>((json) => Productdetails.fromJson(json)).toList();
  //  });
      
   
  //   return Data;
    
  // }

}
