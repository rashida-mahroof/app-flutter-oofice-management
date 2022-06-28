import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/home.dart';
import 'package:untitled/Model/users.dart';
import 'dart:async';
import 'dart:convert';
import 'Taskclass.dart';
import 'Taskcreate.dart';
import 'Taskdetailview.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

Future<List<dynamic>> fetchUsers(int userid, int Type) async {
  final String apiUrl =
      "https://www.hokybo.com/tms/api/Task/GetAllDetails?userId=" +
          userid.toString() +
          "&Type=" +
          Type.toString();
  var result = await http.get(Uri.parse(apiUrl));
  return json.decode(result.body)['data'];
}

String _name(dynamic user) {
  return user['Name'];
}

String _date(dynamic user) {
  return user['Dates'];
}

String _time(dynamic user) {
  return user['time'];
}

String _status(dynamic user) {
  return user['Status'];
}

int _id(dynamic user) {
  return user['TaskId'];
}

int _imgid(dynamic user) {
  return user['UserID'];
}

String _location(dynamic user) {
  return user['Role'];
}

String _Subject(dynamic user) {
  return user['Subject'];
}

var detaildata;

List<dynamic> detaildata1=[];

class _TaskState extends State<Task> with TickerProviderStateMixin {
  TaskClass Obj1 = TaskClass();
  getItemAndNavigate(int index, BuildContext context) async {
    var response2 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/Task/GetAllDetailsByID?ApprId=" +
            index.toString()+"&UserID="+globals.login_id.toString()));
    if (response2.statusCode == 200) {
      detaildata = json.decode(response2.body)['data'];

      var response3 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/TaskUpd/GetTransmissionDetaiils?TaskID=" +
            index.toString()));
            if(response3.statusCode == 200)
            {
              print(response3.body);
              detaildata1 = json.decode(response3.body);
               Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) => Taskdetail(Obj: detaildata,Transmission:detaildata1,)));
            }
     
    }
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  Widget appBarTitlet =  const Text("Tasks");
  Icon actionIcont =  const Icon(Icons.search);
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
        title:appBarTitlet,
        actions: <Widget>[
          Row(
            children: [
              IconButton(icon: actionIcont,onPressed:(){
                setState(() {
                  if ( actionIcont.icon == Icons.search){
                    actionIcont =  const Icon(Icons.close);
                    appBarTitlet = const TextField(
                      cursorColor: Colors.white,
                      autofocus: true,
                      style:  TextStyle(
                        color: Colors.white,

                      ),
                      decoration: InputDecoration(
                          // prefixIcon:  Icon(Icons.search,color: Colors.white),
                          hintText: "Search...",

                          border:InputBorder.none,
                          hintStyle:  TextStyle(color: Colors.white70)
                      ),
                    );}
                  else {
                    actionIcont =  Icon(Icons.search);
                    appBarTitlet =  Text("Tasks");
                  }


                });
              } ,),
              if(actionIcont.icon == Icons.close)
                IconButton(
                    onPressed: () {
                      print('search button');
                    },
                    tooltip: 'Search',
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
          ),],
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const <Widget>[Tab(text: 'Received'), Tab(text: 'Created')]),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Center(
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: fetchUsers(globals.login_id, 1),
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
                              'There are no Tasks ',
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
                        return ListTile(
                        onTap:(){
                        getItemAndNavigate(
                        _id(snapshot.data[index]), context);
                        },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://www.hokybo.com/assets/Users/" +
                                    _imgid(snapshot.data[index])
                                        .toString() +
                                    ".jpg?"),
                          ),
                          title: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name(snapshot.data[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    GoogleFonts.poppins(fontSize: 13),
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
                          subtitle: Text(
                            _Subject(snapshot.data[index]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: Colors.black54),
                          ),
                          trailing: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              if (_status(snapshot.data[index]) ==
                                  "Opened") //if opened
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    'Opened',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.teal),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Unopened") //if unopened
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    'Unopened',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Pending")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Completed")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.teal.shade900),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Failed")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Success") //tast completed
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text('Completed',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "InComplete") //tast completed
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text('InComplete',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red.shade600),
                                  ),
                                ),
                              Text(
                                _time(snapshot.data[index]),
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                              Text(
                                _date(snapshot.data[index])
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          selectedTileColor: Colors.green,
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
              future: fetchUsers(globals.login_id, 0),
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
                              'There are no Tasks ',
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
                        return ListTile(
                          onTap: () {
                            getItemAndNavigate(
                                _id(snapshot.data[index]), context);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              "https://www.hokybo.com/assets/Users/" +
                                  _imgid(snapshot.data[index])
                                      .toString() +
                                  ".jpg?",
                            ),
                          ),
                          title: Text(
                            _Subject(snapshot.data[index]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.black),
                          ),
                          trailing: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              if (_status(snapshot.data[index]) ==
                                  "Opened") //if opened
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    'Opened',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.teal),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Unopened") //if unopened
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    'Unopened',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Pending")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Completed")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Failed")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text(
                                    _status(snapshot.data[index]),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "Success") //tast completed
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text('Completed',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green),
                                  ),
                                ),
                              if (_status(snapshot.data[index]) ==
                                  "InComplete") //tast completed
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: Text('InComplete',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red.shade600),
                                  ),
                                ),
                              Text(
                                _time(snapshot.data[index]),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black45),
                              ),
                              Text(
                                _date(snapshot.data[index]),
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name(snapshot.data[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    GoogleFonts.poppins(fontSize: 11),
                              ),
                              // Text(
                              //   _location(snapshot.data[index])
                              //       .toLowerCase(),
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: GoogleFonts.poppins(
                              //       fontSize: 9,
                              //       color: Colors.black38),
                              // ),
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
                builder: (BuildContext context) => const Addnewtask()),
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
    user = User.fromJson(json1);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }
}
