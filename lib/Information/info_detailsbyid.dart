import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Approval/fullscreenImgView.dart';
import '../Login/home.dart';
import '../Model/users.dart';

class InfoDetailsById extends StatefulWidget {
  final int InfoID;
  final int type;
  final int count;
  InfoDetailsById(
      {Key? key, required this.type, required this.InfoID, required this.count})
      : super(key: key);

  @override
  State<InfoDetailsById> createState() => _InfoDetailsByIdState();
}

class _InfoDetailsByIdState extends State<InfoDetailsById>
    with TickerProviderStateMixin {
  late int IID = widget.InfoID;
  late int type = widget.type;
  late int count = widget.count;

  @override
  Future<List<dynamic>> fetchInfobyid(int ID, int tipe) async {
    final String apiUrl =
        "https://www.hokybo.com/tms/api/Information/GetInformationByID?InfoID=" +
            ID.toString() +
            "&type=" +
            tipe.toString()+"&UserID="+globals.login_id.toString();

    var result = await http.get(Uri.parse(apiUrl));

    return json.decode(result.body);
  }

  int _infoid(dynamic user) {
    return user['InfoId'];
  }

  String _sub(dynamic user) {
    return user['Subject'];
  }

  String _content(dynamic user) {
    return user['Content'];
  }

  String _img(dynamic user) {
    return user['Image'];
  }

  String _rname(dynamic user) {
    return user['Name'];
  }

  String _createdDate(dynamic user) {
    return user['CreatedDate'];
  }

  String _createdTime(dynamic user) {
    return user['CreatedTime'];
  }

  String _imgcnt(dynamic user) {
    return user['ImageCount'];
  }

  String _rolename(dynamic user) {
    return user['RoleName'];
  }

  Widget build(BuildContext ctx) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'INFID' + IID.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
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
            centerTitle: true,
          ),
          body: FutureBuilder<List<dynamic>>(
            future: fetchInfobyid(IID, type),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                          child: Padding(
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
                                    Text(
                                      type > 0
                                          ? 'Recieved Date :'
                                          : 'Created Date :',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.orange.shade500),
                                    ),
                                    Text(
                                      _createdTime(snapshot.data[0]),
                                      style: GoogleFonts.poppins(
                                          fontSize: 11, color: Colors.black54),
                                    ),
                                    Text(
                                      _createdDate(snapshot.data[0]),
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
                                    Text(
                                      type > 0 ? 'From :' : 'For :',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: Colors.orange.shade500),
                                    ),
                                    Text(
                                      _rname(snapshot.data[0]),
                                      style: GoogleFonts.poppins(
                                        color: Colors.teal,
                                        //  fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decorationColor: Colors.blue,
                                      ),
                                    ),
                                    if (_rolename(snapshot.data[0]).isNotEmpty)
                                      Text(
                                        '( ' +
                                            _rolename(snapshot.data[0]) +
                                            ')',
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
                                    child: Text(_sub(snapshot.data[0]),
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
                                      _content(snapshot.data[0]),
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

                            // Padding(
                            //   padding: const EdgeInsets.all(10),
                            //   child: Column(
                            //     children: [
                            //       CarouselSlider(
                            //         options: CarouselOptions(height: 400.0),
                            //         items: [1, 2, 3, 4].map((i) {
                            //           return Builder(
                            //             builder: (BuildContext context) {
                            //               return Container(
                            //                 width:
                            //                     MediaQuery.of(context).size.width,
                            //                 margin: EdgeInsets.symmetric(
                            //                     horizontal: 5.0),
                            //                 decoration:
                            //                     BoxDecoration(color: Colors.blue),
                            //                 child: Image.network(
                            //                   "https://www.hokybo.com/assets/UploadFiles/" +
                            //                       Obj[0]['ApprovalId'].toString() +
                            //                       "/" +
                            //                       i.toString() +
                            //                       ".jpg",
                            //                   fit: BoxFit.fill,
                            //                   loadingBuilder:
                            //                       (ctx, child, loadingProgress) {
                            //                     if (loadingProgress == null) {
                            //                       return child;
                            //                     } else {
                            //                       return Center(
                            //                         child:
                            //                             CircularProgressIndicator(
                            //                           valueColor:
                            //                               AlwaysStoppedAnimation<
                            //                                   Color>(Colors.green),
                            //                         ),
                            //                       );
                            //                     }
                            //                   },
                            //                   errorBuilder:
                            //                       (ctx, exception, stackTrace) {
                            //                     return Text('No attachments...');
                            //                   },
                            //                 ),
                            //               );
                            //             },
                            //           );
                            //         }).toList(),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            //-------------------------------------------------------------------------------
                          ],
                        ),
                      )),
                      // Row(
                      //   children: [
                      //     Flexible(
                      //       child: Text(
                      //         _sub(snapshot.data[0]),
                      //         style: GoogleFonts.poppins(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500),
                      //         textAlign: TextAlign.justify,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   _content(snapshot.data[0]),
                      //   style: GoogleFonts.poppins(
                      //       color: Colors.black54,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400),
                      //   textAlign: TextAlign.justify,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [
                      //         Text(
                      //           _rname(snapshot.data[0]),
                      //           style: GoogleFonts.poppins(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w500),
                      //         ),
                      //         Column(
                      //           children: [
                      //             Text(
                      //               _createdDate(snapshot.data[0]),
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 14, color: Colors.blue),
                      //             ),
                      //             Text(
                      //               _createdTime(snapshot.data[0]),
                      //               style: GoogleFonts.poppins(
                      //                   fontSize: 14, color: Colors.blue),
                      //             )
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // Padding(padding: EdgeInsets.all(10)),
                      // Detailedfor(type, _rname(snapshot.data[0])),
                      // SubjectSho(_sub(snapshot.data[0])),
                      // Divider(),
                      // SizedBox(
                      //   height: 2,
                      // ),
                      // ShowContent(_content(snapshot.data[0])),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < count; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Hero(
                                    tag: '',
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return FullScreenImage(
                                              imageUrl:
                                                  "https://www.hokybo.com/assets/information/" +
                                                      IID.toString() +
                                                      "/" +
                                                      IID.toString() +
                                                      "_" +
                                                      i.toString() +
                                                      ".jpg");
                                        }));
                                      },
                                      child: ClipRRect(
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              60), // Image radius
                                          child: Image.network(
                                            "https://www.hokybo.com/assets/information/" +
                                                IID.toString() +
                                                "/" +
                                                IID.toString() +
                                                "_" +
                                                i.toString() +
                                                ".jpg",
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (ctx, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return const Center(
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
                                )
                            ]),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  Widget getType(int type) {
    if (type == 1) {
      return Text(
        'From:    ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      );
    } else {
      return Text(
        'To:      ',
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
  }

  Widget Detailedfor(int type, String Name) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(-0.85, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                  child: InkWell(
                    onTap: () async {},
                    child: getType(type),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 4),
                child: Text(Name,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget SubjectSho(String subject) {
    return Container(
      //color: Colors.indigo.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            // Padding(padding: EdgeInsets.only(left: 5)),
            // RichText(
            //     text: TextSpan(
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 15,
            //   ),
            // )),
            // Padding(padding: EdgeInsets.only(right: 5)),
            // Flexible(
            //     child: Text(
            //   subject,
            // )),

            Text('Subject',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade800,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              subject,
              style: GoogleFonts.poppins(
                  //fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }

  Widget ShowContent(String content) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 5, 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Padding(padding: EdgeInsets.only(left: 5)),
                // RichText(
                //     text: TextSpan(
                //         style: TextStyle(
                //             color: Colors.grey,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15))),
                // Padding(padding: EdgeInsets.only(right: 5)),
                // Flexible(child: Text(content))
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade800),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  content,
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                )
              ]),
        ),
      ),
    );
  }

  // Widget viewimagebutton() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: MaterialButton(
  //             color: Colors.orange.shade700,
  //             child: const Text(
  //               'View Attachment',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => ImageView(
  //                             imgcount: count,
  //                             infoid: IID,
  //                           )));
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
