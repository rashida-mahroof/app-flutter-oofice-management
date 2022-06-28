import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import '../Login/home.dart';
import '../Model/users.dart';

class prospectDetails extends StatefulWidget {
  const prospectDetails({Key? key}) : super(key: key);

  @override
  State<prospectDetails> createState() => _prospectDetailsState();
}

class _prospectDetailsState extends State<prospectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prospect Details'),
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
                            child: Icon(Icons.source, color: Colors.lightBlue),
                          ),
                          Text(
                            'Source',
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
                            'Store',
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
                shape: Border(left: BorderSide(color:Colors.pink

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
                            child: Icon(Icons.bookmark, color: Colors.pink),
                          ),
                          Text(
                            'Subsource',
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
                            'Walking',
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
                shape: Border(left: BorderSide(color:Colors.lightGreen

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
                            child: Icon(Icons.account_circle, color: Colors.lightGreen),
                          ),
                          Text(
                            'Customer Name',
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
                            'Dr. Francis Chakko',
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
                shape: Border(left: BorderSide(color:Colors.purple

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
                            child: Icon(Icons.mobile_screen_share_sharp, color: Colors.purple),
                          ),
                          Text(
                            'Mobile',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {  },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(Icons.call_end,color: Colors.black45,),
                                ),
                                Text(
                                  '9876543210',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: Border(left: BorderSide(color:Color(0xFF93875D)

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
                            child: Icon(Icons.location_on, color: Color(0xFF93875D)),
                          ),
                          Text(
                            'District',
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
                            'Malappuram',
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
                shape: Border(left: BorderSide(color:Colors.orange.shade800

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
                            child: Icon(Icons.location_city, color: Colors.orange.shade800),
                          ),
                          Text(
                            'City',
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
                            'Kuttippala',
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
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(Icons.my_location_rounded,
                                  color: Colors.teal),
                            ),
                            Text(
                              'Address',
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
                          'ABC building, Street 56, San Francisco, 676501 crr tttttttttttttbt',
                          // textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: Border(left: BorderSide(color:Colors.green

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
                            child: Icon(Icons.cloud_done_sharp, color: Colors.green),
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

                          Text(
                            'Success',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' - Order',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: Border(left: BorderSide(color:Colors.cyan.shade300

                    , width: 5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(Icons.chair, color: Colors.cyan.shade300),
                          ),
                          Text(
                            'Products',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            for(int i=1;i<5;i++)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                child: Text(
                                  'sofa',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: Border(left: BorderSide(color:Colors.deepPurpleAccent

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
                            child: Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
                          ),
                          Text(
                            'Delivery Date',
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
                            '12-12-2011',
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
                shape: Border(left: BorderSide(color:Colors.lime.shade700

                    , width: 5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 15),
                  child: Column(

                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(Icons.notes, color: Colors.lime.shade700),
                          ),
                          Text(
                            'Comments',
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
                            'lorem ipsem dolor sit amet',
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
                shape: Border(left: BorderSide(color:Colors.redAccent

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
                            child: Icon(Icons.notes, color: Colors.redAccent),
                          ),
                          Text(
                             'Followup reason',
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
                            'High rate',
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
                shape: Border(left: BorderSide(color:Color(0xFF253A76)

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
                            child: Icon(Icons.note, color: Color(0xFF253A76)),
                          ),
                          Text(
                            'Reason Note',
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
                            'High rate ui',
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
                shape: Border(left: BorderSide(color:Color(0xFF764027)

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
                            child: Icon(Icons.hourglass_top_outlined, color: Color(0xFF764027)),
                          ),
                          Text(
                            'Possibility',
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
                            'Warm',
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
                shape: Border(left: BorderSide(color:Color(0xFFC71DD7)

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
                            child: Icon(Icons.money, color: Color(0xFFC71DD7)),
                          ),
                          Text(
                            'Financial Status',
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
                            'Premium',
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
                shape: Border(
                    left:
                    BorderSide(color: Color(0xFF1B9E45), width: 5)),
                child: ExpansionTile(

                  title: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.chair,color: Color(0xFF1B9E45)),
                      ),
                      Text('Looking Products',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.grey),),
                    ],
                  ),
                  children: <Widget>[
                    for(int i=1;i<6;i++)

                      ListTile(
                        leading: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black26,size: 15,),
                        //   trailing: Icon(Icons.done,color: Colors.black26,size: 15,),
                        title: Wrap(
                          spacing: 15,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sofa',style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45,fontWeight: FontWeight.w600),),
                                Text('Size: 6:78',style: GoogleFonts.poppins(fontSize: 13,color: Colors.black45,fontWeight: FontWeight.w500),),
                              ],
                            ),

                          ],),
                        subtitle:  Text('material: Mahagony',style: GoogleFonts.poppins(fontSize: 13,color: Colors.black45,fontWeight: FontWeight.w500),),
                        trailing: Text('3400 /-',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w400),),
                      ),

                  ],
                ),
              ),
              Card(
                shape: Border(left: BorderSide(color:Color(0xFFD77D1D)

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
                            child: Icon(Icons.date_range, color: Color(0xFFD77D1D)),
                          ),
                          Text(
                            'Next Follow up date',
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
                            '12-12-2022',
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
                shape: Border(left: BorderSide(color: Color(0xFF14CBDC)

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
                            child: Icon(Icons.next_plan, color: Color(0xFF14CBDC)),
                          ),
                          Text(
                            'Next step',
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
                            'Quotation',
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
            ],
          ),
        ),
      ),
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
}
