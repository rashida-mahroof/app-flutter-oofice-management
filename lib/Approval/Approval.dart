
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Approval/Approval_Details.dart';
import 'dart:async';
import 'dart:convert';
import 'package:untitled/Approval/DetailsShow.dart';
import 'package:untitled/Login/home.dart';
import '../Model/users.dart';
import 'ApprovalAdd.dart';

class Information extends StatefulWidget {
  final String search;
  const Information({Key? key, required this.search}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

Future<List<dynamic>> fetchUsers(int userid, int Type,String Search) async {
  final String apiUrl =
      "https://www.hokybo.com/tms/api/Approval/GetAllDetails1?userId=" +
          userid.toString() +
          "&Type=" +
          Type.toString()+"&Search="+Search.toString();
  var result = await http.get(Uri.parse(apiUrl));
  return json.decode(result.body)['data'];
}

String _name(dynamic user) {
  return user['Name'];
}

String _Date(dynamic user) {
  return user['Date'];
}

String _Time(dynamic user) {
  return user['Time'];
}

String _Urgency(dynamic user) {
  return user['Urgency'];
}

String _Status(dynamic user) {
  return user['Status'];
}

int _id(dynamic user) {
  return user['ApprovalId'];
}

int _imgid(dynamic user) {
  return user['Created'];
}

String _location(dynamic user) {
  return user['Role'];
}

String _Subject(dynamic user) {
  return user['Subject'];
}

var detaildata;

class _InformationState extends State<Information>
    with TickerProviderStateMixin {
  SamplePostClass Obj1 = SamplePostClass();
  getItemAndNavigate(int index, BuildContext context) async {
    var response2 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/Approval/GetAllDetailsByID?ApprId=" +
            index.toString()+'&UserId='+globals.login_id.toString()));
    if (response2.statusCode == 200) {
      detaildata = json.decode(response2.body)['data'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) => Detailshow(Obj: detaildata)));
    }
  }

  late TabController _tabController;
  String _searchtxt="null";
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchtxt=widget.search;
  }
  final textController = TextEditingController();
  var searchcontroller = TextEditingController();
  Widget appBarTitle =  const Text("Approvals");
  Icon actionIcon =  const Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

        title:appBarTitle,

          actions: <Widget>[

            Row(
              children: [
                IconButton(icon: actionIcon,onPressed:(){
                  setState(() {
                    if ( actionIcon.icon == Icons.search){
                      actionIcon =  const Icon(Icons.close);
                      appBarTitle =  TextField(
                        cursorColor: Colors.white,
                        autofocus: true,
                        style:  TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            // prefixIcon:  Icon(Icons.search,color: Colors.white),
                            hintText: "Search...",

                            // suffixIcon: Icon(Icons.search),
                            border:InputBorder.none,
                            hintStyle:  TextStyle(color: Colors.white70)
                        ),
                        controller: searchcontroller,
                      );}
                    else {
                      actionIcon =  Icon(Icons.search);
                      appBarTitle =  Text("Approval");
                    }


                  });
                } ,),
                if(actionIcon.icon == Icons.close)
                IconButton(
                    onPressed: () {

                        _searchtxt=searchcontroller.text;
                        if(_searchtxt=="")
                          {
                            _searchtxt="null";
                          }

                      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context1) => Information(search: _searchtxt,)));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      redirecttohome(context);
                    },
                    icon: Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.white,
                    )),
              ],
            ),
          ],

        bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: const <Widget>[Tab(text: 'Received'), Tab(text: 'Created')]),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Center(
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: fetchUsers(globals.login_id, 1,widget.search),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.hasData) {

                  if(snapshot.data.length==0)

                    {
                      return
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/nodata.jpg',
                              ),
                              Text(
                                'There are no Approvals ',
                                style: GoogleFonts.poppins(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                              Text(
                                'Check again later or create new one',
                                style: GoogleFonts.poppins(color: Colors.black45, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  else {
                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            getItemAndNavigate(
                                _id(snapshot.data[index]), context);
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "https://www.hokybo.com/assets/Users/" +
                                        _imgid(snapshot.data[index])
                                            .toString() +
                                        ".jpg?",
                                  ),
                                ),

                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'APID' +
                                          _id(snapshot.data[index])
                                              .toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.black54),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _name(snapshot.data[index]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          _location(snapshot.data[index])
                                              .toLowerCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                _Subject(snapshot.data[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 11, color: Colors.black54),
                                ),
                                trailing:  Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'YELLOW')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow.shade700,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'RED')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'GREEN')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Approved")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.green),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Pending")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Rejected")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.red),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Closed")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          'Completed',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.blueGrey),
                                        ),
                                      ),
                                    Text(
                                      _Time(snapshot.data[index]),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black45),
                                    ),
                                    Text(
                                      _Date(snapshot.data[index]),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                selectedTileColor: Colors.green,
                              ),
                              new Divider(),
                            ],
                          ),
                        );
                      });
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        Center(
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: fetchUsers(globals.login_id, 0,_searchtxt),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data.length==0)
                  {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/nodata.jpg',
                            ),
                            Text(
                              'There are no Approvals ',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              'Check again later or create new one',
                              style: GoogleFonts.poppins(color: Colors.black45, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    );
                  }else {
                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            getItemAndNavigate(
                                _id(snapshot.data[index]), context);
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "https://www.hokybo.com/assets/Users/" +
                                        _imgid(snapshot.data[index])
                                            .toString() +
                                        ".jpg?",
                                  ),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AprID' +
                                          _id(snapshot.data[index])
                                              .toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.black54),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 3),
                                              child: Icon(Icons.done_all,size: 15,
                                                color: (1==1) ? Colors.deepOrange : Colors.grey,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _Subject(snapshot.data[index])+ 'lifg rer erer wew3e4 werw4gb',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _name(snapshot.data[index]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  _location(snapshot.data[index]).toLowerCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 10, color: Colors.black38),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'YELLOW')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow.shade700,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'RED')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Urgency(
                                        snapshot.data[index]) ==
                                        'GREEN')
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Container(
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50)),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Approved")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.green),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Pending")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Rejected")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          _Status(snapshot.data[index]),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.red),
                                        ),
                                      ),
                                    if (_Status(snapshot.data[index]) ==
                                        "Closed")
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 1),
                                        child: Text(
                                          'Completed',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: Colors.blueGrey),
                                        ),
                                      ),
                                    Text(
                                      _Time(snapshot.data[index]),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black45),
                                    ),
                                    Text(
                                      _Date(snapshot.data[index]),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                selectedTileColor: Colors.green,
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      });
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade700,
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => Addnew()),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  redirecttohome(BuildContext context) async {
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

  void test123() {
    print('hi');
  }
}
