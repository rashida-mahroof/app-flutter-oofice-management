import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Approval/ApprovalHistory.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:path/path.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'Approval.dart';
import 'fullscreenImgView.dart';
import 'package:url_launcher/url_launcher.dart';

String selectedCity = "";

class Detailshow extends StatefulWidget {
  final List<dynamic> Obj;

  Detailshow({Key? key, required this.Obj}) : super(key: key);

  @override
  State<Detailshow> createState() => _DetailshowState();
}

class _DetailshowState extends State<Detailshow> {
  final Status = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  late List<String>fileLIst=[];
  String AID = '';

  @override
  void initState() {
    super.initState();
    AID = widget.Obj[0]['ApprovalId'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    'APID' + AID,
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
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovalHistory(ApprID:widget.Obj[0]['ApprovalId'])));
                          },
                          tooltip: "Approval History",
                          icon: Icon(
                            Icons.history,
                            size: 25,
                            color: Colors.white,
                          )),

                      IconButton(
                          onPressed: () {
                            redirectHome(context);
                          },
                          icon: Icon(
                            Icons.home,
                            size: 25,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
              ],
            ),
            body: Column(children: [
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(''),
                                    if (widget.Obj[0]['UserID'] ==
                                        globals.login_id)
                                      Text(
                                        'Created Date :',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.orange.shade500),
                                      ),
                                    if (widget.Obj[0]['UserID'] !=
                                        globals.login_id)
                                      Text(
                                        'Received Date :',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.orange.shade500),
                                      ),
                                    Text(
                                      widget.Obj[0]['Time'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 11, color: Colors.black54),
                                    ),
                                    Text(
                                      widget.Obj[0]['CreatedDate'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.black54,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (widget.Obj[0]['UserID'] !=
                                        globals.login_id)
                                      Text(
                                        'From :',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.orange.shade500),
                                      ),
                                    if (widget.Obj[0]['UserID'] ==
                                        globals.login_id)
                                      Text(
                                        'From :',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.orange.shade500),
                                      ),
                                    Text(
                                      widget.Obj[0]['Name']!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.teal,
                                        //  fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decorationColor: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      '( ' + widget.Obj[0]['Role']! + ')',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
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
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 6),
                                    child: Text(widget.Obj[0]['Subject']!,
                                        style: GoogleFonts.poppins(
                                            //color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.justify),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  top: -5,
                                  child: Container(
                                      color: Colors.grey[50],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          'Subject',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.orange.shade500),
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
                                          color: Colors.orange.shade300),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 6),
                                    child: Text(
                                      widget.Obj[0]['Message']!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        //  fontWeight: FontWeight.w500
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  top: -5,
                                  child: Container(
                                      color: Colors.grey[50],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          'Message',
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange.shade500,
                                            fontSize: 11,
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 90),
                                  child: Text(
                                    'Urgency  : ',
                                    style: GoogleFonts.poppins(
                                      color: Colors.orange.shade500,
                                      fontSize: 11,
                                      // fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),

                                if (widget.Obj[0]['Urgency'] == 'GREEN')
                                  Text(
                                    'LOW',
                                    style: GoogleFonts.poppins(
                                        color: Colors.green,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                else if (widget.Obj[0]['Urgency'] == 'YELLOW')
                                  Text(
                                    'NORMAL',
                                    style: GoogleFonts.poppins(
                                        color: Colors.orange.shade700,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                else if ((widget.Obj[0]['Urgency'] == 'RED'))
                                  Text(
                                    'URGENT',
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),

                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 90),
                                  child: Text(
                                    'Status  : ',
                                    style: GoogleFonts.poppins(
                                      color: Colors.orange.shade500,
                                      fontSize: 11,
                                      // fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                if (widget.Obj[0]['Status']! == 'Approved')
                                  Text(
                                    widget.Obj[0]['Status']!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.green,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                if (widget.Obj[0]['Status']! == 'Rejected')
                                  Text(
                                    widget.Obj[0]['Status']!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                if (widget.Obj[0]['Status']! == 'Pending')
                                  Text(
                                    widget.Obj[0]['Status']!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.orange,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                if (widget.Obj[0]['Status']! == 'Closed')
                                  Text(
                                    'Completed',
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        //    fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.Obj[0]['Status'] != 'Pending')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.Obj[0]['Status'] + ' by :',
                                    style: GoogleFonts.poppins(
                                      color: Colors.orange.shade500,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(widget.Obj[0]['RcName'],
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 12)),
                                ],
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.Obj[0]['Status'] != 'Pending')
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Modified Date :',
                                    style: GoogleFonts.poppins(
                                      color: Colors.orange.shade500,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    widget.Obj[0]['RecievedDate'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            if (widget.Obj[0]['Status'] != 'Pending')
                              Stack(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.teal.shade300),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 6),
                                      child: Text(
                                        widget.Obj[0]['Comment'].toString(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    top: -5,
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'Reason for ' +
                                                widget.Obj[0]['Status'],
                                            style: GoogleFonts.poppins(
                                              color: Colors.teal.shade500,
                                              fontSize: 11,
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    for (int i = 0;
                                        i < widget.Obj[0]['files'].length;
                                        i++)
                                        if(widget.Obj[0]['files'][i].toString().contains('.jpg') || widget.Obj[0]['files'][i].toString().contains('.png'))
                                        
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Hero(
                                          tag: '',
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return FullScreenImage(
                                                    imageUrl:
                                                        "https://www.hokybo.com/assets/UploadFiles/" +
                                                            widget.Obj[0][
                                                                    'ApprovalId']
                                                                .toString() +
                                                            "/" +widget.Obj[0]['files'][i].toString()
                                                            );
                                              }));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(
                                                    60), // Image radius
                                                child: Row(
                                                  children: [

                                                    Image.network(
                                                      "https://www.hokybo.com/assets/UploadFiles/" +
                                                          widget.Obj[0]
                                                                  ['ApprovalId']
                                                              .toString() +
                                                          "/" +widget.Obj[0]['files'][i].toString(),
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (ctx, child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        } else {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors.teal),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder: (ctx, exception,
                                                          stackTrace) {
                                                        return Text(
                                                            'No attachments...');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      else
                                      GestureDetector(
                                      onTap: (){
                                        _launchURL(widget.Obj[0]['files'][i].toString());
                                      },
                                      child: ClipRRect(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(60), // Image radius
                                          child: Column(
                                            children: [
                                              Icon(Icons.note,size: 100,color: Colors.grey,),
                                              Text('document',style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.Obj[0]['Status'] == 'Pending' &&
                            widget.Obj[0]['UserID'] == globals.login_id && widget.Obj[0]['Type']!='Shared')
                          Reject(context),
                        if (widget.Obj[0]['Status'] == 'Pending' &&
                            widget.Obj[0]['UserID'] == globals.login_id && widget.Obj[0]['Type']!='Shared')
                          Approve(context),
                        if (widget.Obj[0]['Status'] == 'Approved' && widget.Obj[0]['Type']!='Shared')
                          Forward(context),
                        if (widget.Obj[0]['Status'] == 'Approved')
                          Share(context),
                        if (widget.Obj[0]['Status'] == 'Approved' && widget.Obj[0]['Type']!='Shared')
                          Closea(context),
                      ]),
                ),
              ),
            ])));
  }
  Widget Approve(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var aprvBtnTxt = 'Approve';
                Color aprBtnClr = Colors.green;
                bool _isPressed = false;
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                      return  AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            // Positioned(
                            //   right: -50.0,
                            //   top: -50.0,
                            //   child: InkResponse(
                            //     onTap: () {
                            //       Navigator.pushReplacement(
                            //           context,
                            //           new MaterialPageRoute(
                            //               builder: (BuildContext context) =>
                            //                   new Information()));
                            //     },
                            //     child: CircleAvatar(
                            //       child: Icon(Icons.close),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 200,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Comments",
                                        border: OutlineInputBorder()),
                                    controller: Status,
                                    maxLines: null,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed:
                                              () async {
                                            setState((){
                                              aprvBtnTxt = 'Processing...';
                                              aprBtnClr = Colors.grey.shade300;
                                            });
                                            print(widget.Obj[0]['ApprovalId']);
                                            var response2 = await http.post(
                                                Uri.parse(
                                                    'https://www.hokybo.com/tms/api/ApprovalUpd/Status'),
                                                headers: {
                                                  "Content-Type":
                                                  "application/x-www-form-urlencoded",
                                                },
                                                encoding: Encoding.getByName('utf-8'),
                                                body: ({
                                                  'ApprovalId': widget.Obj[0]['ApprovalId']
                                                      .toString(),
                                                  'Status': 'Approved',
                                                  if(Status.text!='')
                                                    'Comment': Status.text
                                                  else
                                                    'Comment':'null'
                                                }));
                                            if (response2.statusCode == 201) {
                                              Fluttertoast.showToast(
                                                  msg: 'Approved Successfully',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white);
                                              Navigator.pushReplacement(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                      new Information(search: 'null',)));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Error Occurred',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            }
                                            setState((){
                                              aprvBtnTxt = 'Approved';
                                              aprBtnClr = Colors.green;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new Information(search: 'null',)));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: aprBtnClr),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child:  Text(
                                              aprvBtnTxt,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                  },

                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Approve',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Reject(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var rejBtnTxt = 'Reject';
                Color rejBtnClr = Colors.red;
                return StatefulBuilder(
                  builder: ( context, setState) {
                    return  AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -50.0,
                            top: -50.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new Information(search: 'null',)));
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Comments",
                                      border: OutlineInputBorder()),
                                  controller: Status,
                                  maxLines: null,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState((){
                                            rejBtnClr = Colors.grey.shade300;
                                            rejBtnTxt = 'Processing...';
                                          });
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/ApprovalUpd/Status'),
                                              headers: {
                                                "Content-Type":
                                                "application/x-www-form-urlencoded",
                                              },
                                              encoding: Encoding.getByName('utf-8'),
                                              body: ({
                                                'ApprovalId': widget.Obj[0]['ApprovalId']
                                                    .toString(),
                                                'Status': 'Rejected',

                                                if(Status.text!='')
                                                  'Comment': Status.text
                                                else
                                                  'Comment':'null'
                                              }));
                                          if (response2.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Rejected Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new Information(search: 'null',)));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            rejBtnClr = Colors.red;
                                            rejBtnTxt = 'Rejected';
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                  new Information(search: 'null',)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: rejBtnClr),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 50),
                                          child: Text(
                                            rejBtnTxt,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },

                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Reject',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Forward(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context1,
            builder: (context1) {
              final ImagePicker imagePicker = ImagePicker();
                var frwdBtnTxt = 'Forward';
                Color frwdBtnClr = Colors.teal;
              return StatefulBuilder(builder: (context1, setState) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -50.0,
                        top: -50.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.pushReplacement(
                                context1,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new Information(search:'null' )));
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        height: 500,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DropDownList(),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Comments",
                                    border: OutlineInputBorder()),
                                controller: Status,
                                maxLines: null,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;
                                            i < imageFileList!.length;
                                            i++)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    child: SizedBox.fromSize(
                                                      size: Size.fromRadius(
                                                          60), // Image radius
                                                      child: Image.file(
                                                        File(imageFileList![i]
                                                            .path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: IconButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            imageFileList!.remove(
                                                                imageFileList![
                                                                    i]);
                                                          });
                                                        },
                                                        icon: Container(
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      70,
                                                                      70),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Center(
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                      // PreviewImg()
                                      ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton.icon(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Color.fromARGB(255, 49, 49, 49),
                                        context: context1,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60, vertical: 30),
                                            child: Container(
                                              height: 80,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          // getImagebyCamera();
                                                          PickedFile? pick =
                                                              await imagePicker.getImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera,
                                                                  imageQuality:
                                                                      50,
                                                                  maxHeight:
                                                                      640,
                                                                  maxWidth:
                                                                      480);
                                                          if (pick != null) {
                                                            setState(() {
                                                              imageFileList!
                                                                  .add(File(pick
                                                                      .path));
                                                            });
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        tooltip:
                                                            "Pick Image form Camera",
                                                        child: const Icon(
                                                            Icons.add_a_photo),
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      FloatingActionButton(
                                                        onPressed: () async {
                                                          // getImagebyGallery();
                                                          try {
                                                            final List<XFile>?
                                                                selectedImages =
                                                                await imagePicker
                                                                    .pickMultiImage(
                                                                        imageQuality:
                                                                            50,
                                                                        maxHeight:
                                                                            640,
                                                                        maxWidth:
                                                                            480);

                                                            setState(() {
                                                              if (selectedImages!
                                                                  .isNotEmpty) {
                                                                for (int s = 0;
                                                                    s <
                                                                        selectedImages
                                                                            .length;
                                                                    s++) {
                                                                  imageFileList!
                                                                      .add(File(
                                                                          selectedImages[s]
                                                                              .path));
                                                                }
                                                              }
                                                            });
                                                          } on Exception catch (ex) {
                                                            print(ex);
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        tooltip:
                                                            "Pick Image form Gallery",
                                                        child: const Icon(
                                                            Icons.camera),
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.teal,
                                  ),
                                  label: Text(
                                    'Add Image',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState((){
                                          frwdBtnClr = Colors.grey.shade300;
                                          frwdBtnTxt = 'Processing...';
                                        });
                                        var Posturi = Uri.parse(
                                            'https://www.hokybo.com/tms/api/ApprovalUpd/Forward?a=1');
                                        var request =
                                            http.MultipartRequest("POST", Posturi);
                                        request.fields['ApprovalId'] =
                                            widget.Obj[0]['ApprovalId'].toString();
                                        request.fields['Receiver'] = selectedCity;
                                        request.fields['UserId'] =
                                            globals.login_id.toString();
                                        request.fields['Status'] = Status.text;
                                        request.fields['Type']='Forwarded';
                                        if (imageFileList != null) {
                                          for (int i = 0;
                                              i < imageFileList!.length;
                                              i++) {
                                            var stream = http.ByteStream(
                                                DelegatingStream.typed(
                                                    imageFileList![i].openRead()));
                                            var length =
                                                await imageFileList![i].length();
                                            request.files.add(
                                                await http.MultipartFile(
                                                    'File', stream, length,
                                                    filename: basename(
                                                        imageFileList![i].path)));
                                          }
                                        }
                                        request.send().then((response) {
                                          if (response.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Forwarded Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                            Navigator.pushReplacement(
                                                context1,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                        new Information(search: 'null',)));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            frwdBtnTxt = 'Forwarded';
                                            frwdBtnClr =Colors.teal;
                                          });
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: frwdBtnClr),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 50),
                                        child:  Text(
                                          frwdBtnTxt,
                                          style: TextStyle(fontSize: 16),
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
                    ],
                  ),
                );
              });
            },
          );
        },
        style: ElevatedButton.styleFrom(primary: Colors.teal),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Forward',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Share(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var shrBtnTxt = 'Share';
                Color shrBtnClr = Color(0xFF081E68);
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
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new Information(search: 'null',)));
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          height: 400,
                          child: Column(
                            children: [
                              DropDownList(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState((){
                                          shrBtnClr = Colors.grey.shade300;
                                          shrBtnTxt = 'Processing...';
                                        });
                                        var Posturi = Uri.parse(
                                            'https://www.hokybo.com/tms/api/ApprovalUpd/Forward?a=1');
                                        var request =
                                        http.MultipartRequest("POST", Posturi);
                                        request.fields['ApprovalId'] =
                                            widget.Obj[0]['ApprovalId'].toString();
                                        request.fields['Receiver'] = selectedCity;
                                        request.fields['UserId'] =
                                            globals.login_id.toString();
                                        request.fields['Status'] = Status.text;
                                        request.fields['Type']='Shared';
                                        if (imageFileList != null) {
                                          for (int i = 0;
                                          i < imageFileList!.length;
                                          i++) {
                                            var stream = http.ByteStream(
                                                DelegatingStream.typed(
                                                    imageFileList![i].openRead()));
                                            var length =
                                            await imageFileList![i].length();
                                            request.files.add(
                                                await http.MultipartFile(
                                                    'File', stream, length,
                                                    filename: basename(
                                                        imageFileList![i].path)));
                                          }
                                        }
                                        request.send().then((response) {
                                          if (response.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Forwarded Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                            Navigator.pushReplacement(
                                                context1,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new Information(search: 'null',)));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            shrBtnClr = Color(0xFF081E68);
                                            shrBtnTxt = 'Shared';
                                          });
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: shrBtnClr ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 50),
                                        child: Text(
                                          shrBtnTxt,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                    },
                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Color(0xFF081E68)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Share',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Closea(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var clsBtnTxt = 'Completed';
                Color clsBtnClr = Colors.red;
                return StatefulBuilder(
                  builder: (context,setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          // Positioned(
                          //   right: -50.0,
                          //   top: -50.0,
                          //   child: InkResponse(
                          //     onTap: () {
                          //       Navigator.pushReplacement(
                          //           context,
                          //           new MaterialPageRoute(
                          //               builder: (BuildContext context) =>
                          //               new Information()));
                          //     },
                          //     child: CircleAvatar(
                          //       child: Icon(Icons.close),
                          //       backgroundColor: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 300,

                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Icon(Icons.cloud_done_rounded,color: Colors.green,size: 70,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Are you sure to complete this approval',style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45),textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Comments",
                                        border: OutlineInputBorder()),
                                    controller: Status,
                                    maxLines: null,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState((){
                                              clsBtnClr = Colors.grey.shade300;
                                              clsBtnTxt = 'Processing...';
                                            });
                                            var response2 = await http.post(
                                                Uri.parse(
                                                    'https://www.hokybo.com/tms/api/ApprovalUpd/Status'),
                                                headers: {
                                                  "Content-Type":
                                                  "application/x-www-form-urlencoded",
                                                },
                                                encoding: Encoding.getByName('utf-8'),
                                                body: ({
                                                  'ApprovalId': widget.Obj[0]['ApprovalId']
                                                      .toString(),
                                                  'Status': 'Closed',
                                                  if(Status.text!='')
                                                    'Comment': Status.text
                                                  else
                                                    'Comment':'null'
                                                }));
                                            if (response2.statusCode == 201) {
                                              Fluttertoast.showToast(
                                                  msg: 'Approval Completed Successfully',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white);
                                              Navigator.pushReplacement(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                      new Information(search: 'null',)));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Error Occurred',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            }
                                            setState((){
                                              clsBtnClr = Colors.red;
                                              clsBtnTxt = 'Completed';
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    new Information(search: 'null',)));
                                          },
                                          style:
                                          ElevatedButton.styleFrom(primary: clsBtnClr),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              clsBtnTxt,
                                              style: TextStyle(fontSize: 16),
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
                        ],
                      ),
                    );
                  },

                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Colors.deepOrange[500]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Completed',
            style: TextStyle(fontSize: 16),
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
    print(json1);
    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }

  void getImagebyCamera() async {
    PickedFile? pick = await imagePicker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 640,
        maxWidth: 480);
    if (pick != null) {
      setState(() {
        imageFileList!.add(File(pick.path));
      });
    }
  }

  void getImagebyGallery() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
          imageQuality: 50, maxHeight: 640, maxWidth: 480);

      setState(() {
        if (selectedImages!.isNotEmpty) {
          for (int s = 0; s < selectedImages.length; s++) {
            imageFileList!.add(File(selectedImages[s].path));
          }
        }
      });
    } on Exception catch (ex) {
      print(ex);
    }
  }
  _launchURL(String docName) async {
    
    var docurl='https://www.hokybo.com/assets/UploadFiles/' +
                                                          widget.Obj[0]
                                                                  ['ApprovalId']
                                                              .toString() +
                                                          "/" +docName;
    if (await canLaunch(docurl)) {
      await launch(docurl);
    } else {
      throw 'Could not launch $docurl';
    }
  }
  Widget PreviewImg() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < imageFileList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(60), // Image radius
                        child: Image.file(
                          File(imageFileList![i].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              imageFileList!.remove(imageFileList![i]);
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 70, 70),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
        ShowDept(),
    ShowSingle(),
    ShowGroup(),
      ],
    );

    // GetUsers();
    //
    // return DropdownSearch<String>(
    //   //mode of dropdown
    //   mode: Mode.DIALOG,
    //   //to show search box
    //   showSearchBox: true,
    //   showSelectedItems: true,
    //   //list of dropdown items
    //   items: UserList,
    //   label: "To",
    //   onChanged: (value) {
    //     setState(() {
    //       selectedCity = value!;
    //     });
    //   },
    //   //show selected item
    //   selectedItem: "All",
    // );
  }

  late List<String>? UserList = [];
  late List<String>? DeptList = [];
  late List<String>? RoleList = [];


  final subject = TextEditingController();
  final content = TextEditingController();
  GetUsers(String dept, String role) {
    void get_data() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetUserLoading?Role=' +
              role +
              '&Dept=' +
              dept +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Approval'));
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

  String selectedRole = "All";
  String selecteddept = "All";
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
            dropdownSearchDecoration: InputDecoration(
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
              '&WCode=Approval'));
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
          dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.school,
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

  IntiaGetRoles(String deptname) {
    void GetRoles() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Information/GetRoles?ds=' +
              deptname +
              '&UserId=' +
              globals.login_id.toString() +
              '&WCode=Approval'));
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
            validator: (value) {
              if (value == "Select User" || value == null) {
                return "Select Employee";
              } else {
                return null;
              }
            },
            // dropdownSearchDecoration: const InputDecoration(labelText: "To"),
            onChanged: (value) {
              setState(() {
                selectedCity = value!;
              });
            },

            //show selected item
            selectedItem: "Select User",
          ),
        ),
      ),
    );
  }
}
