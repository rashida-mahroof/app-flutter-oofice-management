import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import '../Approval/fullscreenImgView.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'Taskview.dart';

DateTime selectedDate = DateTime.now();
String selectedCity = "";
 TimeOfDay selectedExtendTime=TimeOfDay.now(); 
 DateTime selectedExtendDate = DateTime.now();
  int IsExtended=0;
 int IsExtendedPending=0;
 String inputDate='';

class Taskdetail extends StatefulWidget {
  final List<dynamic> Obj;
  final List<dynamic> Transmission;

  Taskdetail({Key? key, required this.Obj, required this.Transmission}) : super(key: key);

  @override
  State<Taskdetail> createState() => _TaskdetailState();
}

class _TaskdetailState extends State<Taskdetail> {
  final Status = TextEditingController();

  String Urgencys = "";

      String _time='';
    String _date='';
    




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsExtended=0;
    IsExtendedPending=0;
    for(int i=0;i<widget.Transmission.length;i++)
    {
      if(widget.Transmission[i]['Status']=='Extend Pending')
      {
        IsExtendedPending+=1;
        _time=widget.Transmission[i]['UpdatedTime'];
        _date=widget.Transmission[i]['UpdatedDate'];
      }
      if( widget.Transmission[i]['Status']=='Extended')
      {
        IsExtended+=1;
      }
    }
    if(_time!='' && _date!='')
    {
      selectedExtendTime =TimeOfDay(hour:int.parse(_time.split(":")[0]),minute: int.parse(_time.split(":")[1]));
      var inputFormat = DateFormat('dd-MM-yyyy');
      selectedExtendDate = inputFormat.parse(_date);
      // selectedExtendDate=DateTime.parse(_date);
    }

  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
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
            title: Row(
              children: [
                Text(
                  'TSKID' + widget.Obj[0]['TaskId'].toString(),
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
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                  if (widget.Obj[0]['UserID'] == globals.login_id)
                                    Text(
                                      'Created Date :',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.orange.shade500),
                                    ),
                                  if (widget.Obj[0]['UserID'] != globals.login_id)
                                    Text(
                                      'Received Date :',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.orange.shade500),
                                    ),
                                  Text(
                                    widget.Obj[0]['Createdtime'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 11, color: Colors.black54),
                                  ),
                                  Text(
                                    DateFormat.yMMMEd()
                                        .format(DateTime.parse(
                                            widget.Obj[0]['CreatedDate']))
                                        .toString(),
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
                                  if (widget.Obj[0]['UserID'] != globals.login_id)
                                    Text(
                                      'From :',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.orange.shade500),
                                    ),
                                  if (widget.Obj[0]['UserID'] == globals.login_id)
                                    Text(
                                      'For :',
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
                              if (widget.Obj[0]['Urgency']! == 'GREEN')
                                Row(
                                  children: [
                                    Text(
                                      'Low',
                                      style: GoogleFonts.poppins(
                                          color: Colors.green,
                                          //    fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              if (widget.Obj[0]['Urgency']! == 'RED')
                                Text(
                                  'Urgent',
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.Obj[0]['Urgency']! == 'BLUE')
                                Text(
                                  "Normal",
                                  style: GoogleFonts.poppins(
                                      color: Colors.orange,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deadline :',
                                style: GoogleFonts.poppins(
                                  color: Colors.orange.shade500,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMEd()
                                        .format(DateTime.parse(widget.Obj[0]['Date']!))
                                        .toString() +
                                    ' -' +
                                    widget.Obj[0]['time'],
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w500
                                ),
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
                              if (widget.Obj[0]['Status']! == 'Unopened')       //if unopened
                                Text(
                                  'Unopened',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade600,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.Obj[0]['Status']! == 'Opened')         //if opened
                                Text(
                                  'Opened',
                                  style: GoogleFonts.poppins(
                                      color: Colors.teal,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.Obj[0]['Status']! == 'Success')
                                Text(
                                  widget.Obj[0]['Status']!,
                                  style: GoogleFonts.poppins(
                                      color: Colors.green,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.Obj[0]['Status']! == 'Failed')
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
                              if (widget.Obj[0]['Status']! == 'Completed') //completed
                                Text('Completed',
                                  style: GoogleFonts.poppins(
                                      color: Colors.teal.shade900,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.Obj[0]['Status']! == 'InComplete') //incomplete
                                Text(
                                  'InComplete',
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      //    fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          if (widget.Obj[0]['Comment'] != '' &&
                              widget.Obj[0]['Comment'] != null)
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
                                      widget.Obj[0]['Comment'],
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
                                          'Comments',
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
                          if(IsExtendedPending>0 && widget.Obj[0]['UserID']==globals.login_id)
                          Container(
                            width: double.infinity,
                            decoration:BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                                    color: Colors.deepOrange
                            ),
                            
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                               Text(widget.Obj[0]['RecieverName'].toString()+' requested to Extend date to, ' +DateFormat.yMMMEd().format(DateTime.parse(selectedExtendDate.toString())).toString()+','+"${selectedTime.hour}:${selectedTime.minute}" ,style: GoogleFonts.poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                            ),
                          ),
                          // if (Obj[0]['Receiver'] != '2022-02-01' && Obj[0]['Status']=='Extended')
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Changed Date:- ',
                          //         style: GoogleFonts.poppins(
                          //           color: Colors.orange.shade500,
                          //           fontSize: 11,
                          //         ),
                          //       ),
                          //       Text(
                          //         Obj[0]['Receiver']!,
                          //         style: TextStyle(
                          //           color: Colors.blue,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // if (Obj[0]['ReceiverTime'] != '')
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Changed Time:- ',
                          //       style: GoogleFonts.poppins(
                          //         color: Colors.orange.shade500,
                          //         fontSize: 11,
                          //       ),
                          //     ),
                          //     Text(
                          //       Obj[0]['ReceiverTime']!,
                          //       style: TextStyle(
                          //         color: Colors.blue,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 1; i <= widget.Obj[0]['Result']; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return FullScreenImage(
                                              imageUrl:
                                                  "https://www.hokybo.com/assets/TaskFiles/" +
                                                      widget.Obj[0]['TaskId']
                                                          .toString() +
                                                      "/" +
                                                      i.toString() +
                                                      ".jpg");
                                        }));
                                      },
                                      child: ClipRRect(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              60), // Image radius
                                          child: Image.network(
                                            "https://www.hokybo.com/assets/TaskFiles/" +
                                                widget.Obj[0]['TaskId'].toString() +
                                                "/" +
                                                i.toString() +
                                                ".jpg",
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (ctx, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Colors.teal),
                                                  ),
                                                );
                                              }
                                            },
                                            errorBuilder:
                                                (ctx, exception, stackTrace) {
                                              return Text('No attachments...');
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.Obj[0]['UserID'] != globals.login_id && (widget.Obj[0]['Status']=='Opened' || widget.Obj[0]['Status']=='Extended' ||widget.Obj[0]['Status']=='Extend rejected'||widget.Obj[0]['Status']=='Pending') ) Failed(context),
                  if (widget.Obj[0]['UserID'] != globals.login_id && ((widget.Obj[0]['Status']=='Opened') && IsExtended==0 && IsExtendedPending==0)) Pending(context),
                  if (widget.Obj[0]['UserID'] != globals.login_id && (widget.Obj[0]['Status']=='Opened'|| widget.Obj[0]['Status']=='Extended' ||widget.Obj[0]['Status']=='Extend rejected'||widget.Obj[0]['Status']=='Pending')) Success(context),
                  if(widget.Obj[0]['UserID'] == globals.login_id && (widget.Obj[0]['Status']=='Success')) Completed(context),
                  if(widget.Obj[0]['UserID'] == globals.login_id && (widget.Obj[0]['Status']=='Success')) Uncomplete(context),
                   if(widget.Obj[0]['UserID'] == globals.login_id && ((IsExtendedPending>0) && (IsExtended==0)))ExtendDate(context)
                  // if(1==1)ExtendDate(context)
                ],
              ),
            ),
          ])),
    );
  }

  Widget Completed(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
               var cmpltBtnTxt = 'Complete Task';
               Color cmpltBtnClr = Colors.lightGreen;
                return StatefulBuilder(
                  builder: ( context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Comments",
                                      border: OutlineInputBorder()),
                                  controller: Status,
                                  maxLines: 2,
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
                                            cmpltBtnTxt = 'Processing..';
                                            cmpltBtnClr = Colors.grey.shade300;
                                          });
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/Taskupd/StatusUpdate'),
                                              headers: {
                                                "Content-Type":
                                                "application/x-www-form-urlencoded",
                                              },
                                              encoding: Encoding.getByName('utf-8'),
                                              body: ({
                                                'TaskId':
                                                widget.Obj[0]['TaskId'].toString(),
                                                if(Status.text!='')
                                                  'Comment': Status.text
                                                else
                                                  'Comment':'null'
                                                ,'Status': 'Completed'
                                              }));
                                          if (response2.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Updated Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            cmpltBtnTxt = 'Completed';
                                            cmpltBtnClr = Colors.lightGreen;
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Task()));
                                        },
                                        style: ElevatedButton.styleFrom(primary:cmpltBtnClr ),
                                        child:  Text(cmpltBtnTxt),
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
        style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
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

  Widget Uncomplete(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var icmpltBtnTxt = 'Incomplete';
                Color icmpltBtnClr = Colors.deepOrange;
                return StatefulBuilder(
                  builder: ( context,  setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[

                          //Padding(
                          //  padding: const EdgeInsets.all(8.0),
                          //  child: DropDownList(),
                          //),
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Reason",
                                      border: OutlineInputBorder()),
                                  controller: Status,
                                  maxLines: 2,
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
                                            icmpltBtnTxt = 'Processing..';
                                            icmpltBtnClr = Colors.grey.shade300;
                                          });
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/Taskupd/StatusUpdate'),
                                              headers: {
                                                "Content-Type":
                                                "application/x-www-form-urlencoded",
                                              },
                                              encoding: Encoding.getByName('utf-8'),
                                              body: ({
                                                'TaskId':
                                                widget.Obj[0]['TaskId'].toString(),

                                                //'UserId':globals.login_id.toString(),
                                                if(Status.text!='')
                                                  'Comment': Status.text
                                                else
                                                  'Comment':'null',
                                                'Status': "InComplete"
                                              }));
                                          if (response2.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Updated Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            icmpltBtnTxt = 'Uncomplete';
                                            icmpltBtnClr = Colors.deepOrange;
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Task()));
                                        },
                                        style: ElevatedButton.styleFrom(primary: icmpltBtnClr),
                                        child:  Text(icmpltBtnTxt),
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
        style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Incomplete',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Failed(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var fldBtnTxt = 'Send';
                Color fldBtnClr = Colors.red;
                return StatefulBuilder(
                  builder: ( context, setState) {
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
                          //               builder: (BuildContext context) => Task()));
                          //     },
                          //     child: CircleAvatar(
                          //       child: Icon(Icons.close),
                          //       backgroundColor: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          //Padding(
                          //  padding: const EdgeInsets.all(8.0),
                          //  child: DropDownList(),
                          //),
                          Container(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Reason",
                                      border: OutlineInputBorder()),
                                  controller: Status,
                                  maxLines: 2,
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
                                             fldBtnTxt = 'Processing';
                                             fldBtnClr = Colors.grey.shade300;
                                          });
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/Taskupd/StatusUpdate'),
                                              headers: {
                                                "Content-Type":
                                                "application/x-www-form-urlencoded",
                                              },
                                              encoding: Encoding.getByName('utf-8'),
                                              body: ({
                                                'TaskId':
                                                widget.Obj[0]['TaskId'].toString(),

                                                //'UserId':globals.login_id.toString(),
                                                if(Status.text!='')
                                                  'Comment': Status.text
                                                else
                                                  'Comment':'null'
                                                ,'Status': "Failed"
                                              }));
                                          if (response2.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Updated Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            fldBtnTxt = 'Send';
                                            fldBtnClr = Colors.red;
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Task()));
                                        },
                                        style: ElevatedButton.styleFrom(primary: fldBtnClr),
                                        child: Text(fldBtnTxt),
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
            'Failed',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Pending(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var pdngBtnTxt = 'Extend';
                Color pdngBtnClr = Colors.blueAccent;
                return StatefulBuilder(
                  builder: ( context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ask for extend date',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.blueAccent),),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Finish Time:",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    _selectTime(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.access_time_outlined,
                                                    size: 30,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                Text(
                                                  "${selectedTime.hour}:${selectedTime.minute}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Date(),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Comments",
                                        border: OutlineInputBorder()),
                                    controller: Status,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState((){
                                               pdngBtnTxt = 'Processing...';
                                               pdngBtnClr = Colors.grey.shade300;
                                              //  var inputFormat = DateFormat('dd/MM/yyyy');
                                              // inputDate = inputFormat.parse(selectedDate.toString()).toString();
                                            });  
                                            
                                            var response2 = await http.post(
                                                Uri.parse(
                                                    'https://www.hokybo.com/tms/api/Taskupd/ApplyExtend'),
                                                headers: {
                                                  "Content-Type":
                                                  "application/x-www-form-urlencoded",
                                                },
                                                encoding:
                                                Encoding.getByName('utf-8'),
                                                body: ({
                                                  'TaskId':
                                                  widget.Obj[0]['TaskId'].toString(),
                                                  'Status': 'Extend Pending',
                                                  'SenderID':
                                                  globals.login_id.toString(),
                                                  'RecieverId':widget.Obj[0]['UserID'].toString(),
                                                  'UpdatedDate': selectedDate.toString(),
                                                  'UpdatedTime': (selectedTime.hour
                                                      .toString() +
                                                      ":" +
                                                      selectedTime.minute
                                                          .toString())
                                                      .toString(),
                                                  if(Status.text!='')
                                                    'Comment': Status.text
                                                  else 
                                                    'Comment':'null'

                                                }));
                                            if (response2.statusCode == 201) {
                                              Fluttertoast.showToast(
                                                  msg: 'Updated Successfully',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Error Occurred',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            }
                                            setState((){
                                              pdngBtnTxt = 'Success';
                                              pdngBtnClr = Colors.blueAccent;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                        Task()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: pdngBtnClr),
                                          child:  Text(
                                            pdngBtnTxt,
                                            style: TextStyle(fontSize: 16),
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
                    ) ;
                  },

                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Extend',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget ExtendDate(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                var rjctBtntxt = 'Reject';
                Color rjctBtnClr = Colors.deepOrange;
                var pdngBtnTxt = 'Extend';
                Color pdngBtnClr = Colors.blue.shade900;
                return StatefulBuilder(
                  builder: ( context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('-- Extend date --',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.blueAccent),),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Finish Time:",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black38),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    _selectTimeExtend(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.access_time_outlined,
                                                    size: 30,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                Text(
                                                  "${selectedExtendTime.hour}:${selectedExtendTime.minute}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  ExDate(),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Comments",
                                        border: OutlineInputBorder()),
                                    controller: Status,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState((){
                                              rjctBtntxt = 'Processing...';
                                              pdngBtnClr = Colors.grey.shade300;
                                            });

                                            var response2 = await http.post(
                                                Uri.parse(
                                                    'https://www.hokybo.com/tms/api/Taskupd/ApplyExtend'),
                                                headers: {
                                                  "Content-Type":
                                                  "application/x-www-form-urlencoded",
                                                },
                                                encoding:
                                                Encoding.getByName('utf-8'),
                                                body: ({
                                                  'TaskId':
                                                  widget.Obj[0]['TaskId'].toString(),
                                                  'Status': 'Extend Rejected',
                                                  'SenderID':
                                                  globals.login_id.toString(),
                                                  'RecieverId':widget.Obj[0]['RecieverId'].toString(),
                                                  'Date': selectedExtendDate.toString(),
                                                  'time': (selectedExtendTime.hour
                                                      .toString() +
                                                      ":" +
                                                      selectedExtendTime.minute
                                                          .toString())
                                                      .toString(),
                                                  if(Status.text!='')
                                                    'Comment': Status.text
                                                  else
                                                    'Comment':'null'

                                                }));

                                            setState((){
                                              pdngBtnTxt = 'Rejected';
                                              pdngBtnClr = Colors.deepOrange;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                        Task()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: rjctBtnClr),
                                          child:  Text(
                                            rjctBtntxt,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState((){
                                              pdngBtnTxt = 'Processing...';
                                              pdngBtnClr = Colors.grey.shade300;
                                            });

                                            var response2 = await http.post(
                                                Uri.parse(
                                                    'https://www.hokybo.com/tms/api/Taskupd/ApplyExtend'),
                                                headers: {
                                                  "Content-Type":
                                                  "application/x-www-form-urlencoded",
                                                },
                                                encoding:
                                                Encoding.getByName('utf-8'),
                                                body: ({
                                                  'TaskId':
                                                  widget.Obj[0]['TaskId'].toString(),
                                                  'Status': 'Extended',
                                                  'SenderID':
                                                  globals.login_id.toString(),
                                                  'RecieverId':widget.Obj[0]['RecieverId'].toString()
                                                  ,
                                                  'UpdatedDate': selectedExtendDate.toString(),
                                                  'UpdatedTime': (selectedExtendTime.hour
                                                      .toString() +
                                                      ":" +
                                                      selectedExtendTime.minute
                                                          .toString())
                                                      .toString(),
                                                  if(Status.text!='')
                                                    'Comment': Status.text
                                                  else
                                                    'Comment':'null'

                                                }));

                                            setState((){
                                              pdngBtnTxt = 'Extended';
                                              pdngBtnClr = Colors.blue.shade800;
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                        Task()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: pdngBtnClr),
                                          child:  Text(
                                            pdngBtnTxt,
                                            style: TextStyle(fontSize: 16),
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
                    ) ;
                  },

                );
              });
        },
        style: ElevatedButton.styleFrom(primary: Colors.blue.shade900),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'Extend date',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget Success(BuildContext context1) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context) {
                 var scsBtnTxt = 'Success';
                 Color scsBtnClr = Colors.green;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[

                          Container(
                            height: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Comments",
                                      border: OutlineInputBorder()),
                                  controller: Status,
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          setState((){
                                             scsBtnTxt = 'Processing..';
                                             scsBtnClr = Colors.grey.shade300;
                                          });
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/Taskupd/StatusUpdate'),
                                              headers: {
                                                "Content-Type":
                                                "application/x-www-form-urlencoded",
                                              },
                                              encoding: Encoding.getByName('utf-8'),
                                              body: ({
                                                'TaskId':
                                                widget.Obj[0]['TaskId'].toString(),
                                                  if(Status.text!='')
                                                  'Comment': Status.text
                                                  else
                                                  'Comment':'null'
                                                ,'Status': 'Success'
                                              }));
                                          if (response2.statusCode == 201) {
                                            Fluttertoast.showToast(
                                                msg: 'Updated Successfully',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Error Occurred',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                          setState((){
                                            scsBtnTxt = 'Success';
                                            scsBtnClr = Colors.green;
                                          });
                                          Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      Task()));
                                        },
                                        style: ElevatedButton.styleFrom(primary: scsBtnClr),
                                        child:  Text(scsBtnTxt),
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
            'Success',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFF0066FF)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
  
   _selectTimeExtend(BuildContext context) async {
    
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedExtendTime,
        // initialTime:  TimeOfDay(hour:int.parse(selectedExtendTime.toString().split(":")[0]),minute: int.parse(selectedExtendTime.toString().split(":")[1])),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFF0066FF)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (timeOfDay != null && timeOfDay != selectedExtendTime) {
      this.setState(() {
        selectedExtendTime = timeOfDay;
      });
    }
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
}

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    GetUsers();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownSearch<String>(
        //mode of dropdown
        mode: Mode.DIALOG,
        //to show search box
        showSearchBox: true,
        showSelectedItems: true,
        //list of dropdown items
        items: UserList,
        label: "To",
        onChanged: (value) {
          setState(() {
            selectedCity = value!;
          });
        },
        //show selected item
        selectedItem: "All",
      ),
    );
  }

  late List<String>? UserList = ['Select user'];

  final subject = TextEditingController();
  final content = TextEditingController();

  GetUsers() {
    void get_data() async {
      final response = await http.get(
          Uri.parse('https://www.hokybo.com/tms/api/Approval/GetUserLoading'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;

        UserList = [];
        for (int i = 0; i < length; i++) {
          UserList!.add(jsn[i]['Employee'].toString());
        }
      }
    }

    get_data();

    return (UserList);
  }
}

class Date extends StatefulWidget {
  @override
  _Date createState() => _Date();
}

class _Date extends State<Date> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Finish Date:",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black38),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      size: 30,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    style:
                    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              ),

            ],
          ),

        ],
      ),
    );
    // _selectDate(context);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}


class ExDate extends StatefulWidget {
  @override
  _ExDate createState() => _ExDate();
}

class _ExDate extends State<ExDate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Finish Date:",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black38),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      size: 30,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    "${selectedExtendDate.day}/${selectedExtendDate.month}/${selectedExtendDate.year}",
                    style:
                    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              ),

            ],
          ),

        ],
      ),
    );
    // _selectDate(context);
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedExtendDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedExtendDate = selected;
      });
  }
}
