import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Information/info_create.dart';
import 'package:untitled/Login/home.dart';
import 'package:untitled/Model/InformationClass.dart';
import 'package:untitled/Model/users.dart';
import 'info_detailsbyid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Login/globals.dart' as globals;

class InformationView extends StatefulWidget {
  const InformationView({Key? key}) : super(key: key);

  @override
  _InformationViewState createState() => _InformationViewState();
}

String rights = '';
Future<List<dynamic>> fetchInfo(int userid, int type) async {
  final String apiUrl =
      "https://www.hokybo.com/tms/api/Information/GetInformation?userid=" +
          userid.toString() +
          "&type=" +
          type.toString();
  var result = await http.get(Uri.parse(apiUrl));
  //rights=json.decode(result.body)['data']['Rights'][0].toString();
  return json.decode(result.body)['data'];
}

var details;
InfoById ObjInf = InfoById();
getInfobyid(BuildContext ctx, int infoID, int type, int count) {
  Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (ctx) => InfoDetailsById(
                InfoID: infoID,
                type: type,
                count: count,
              )));
}

String _rname(dynamic user) {
  return user['Name'];
}

int _infoid(dynamic user) {
  return user['InfoId'];
}

String _rsubj(dynamic user) {
  return user['Subject'];
}

String _rcont(dynamic user) {
  return user['Content'];
}

String _rcreatedate(dynamic user) {
  return user['CreatedDate'];
}

String _rcreatedtime(dynamic user) {
  return user['CreatedTime'];
}

int _imcount(dynamic user) {
  return user['ImageCount'];
}

int _creatorid(dynamic user) {
  return user['CreatorID'];
}

String _rolename(dynamic user) {
  return user['RoleName'];
}

String _rights(dynamic user) {
  return user['Rights'];
}

class _InformationViewState extends State<InformationView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  Widget appBarTitlei =  const Text("Informations");
  Icon actionIconi =  const Icon(Icons.search);
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
        title:appBarTitlei,
        actions: <Widget>[
          Row(
            children: [
              IconButton(icon: actionIconi,onPressed:(){
                setState(() {
                  if ( actionIconi.icon == Icons.search){
                    actionIconi =  const Icon(Icons.close);
                    appBarTitlei = const TextField(
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
                    actionIconi =  Icon(Icons.search);
                    appBarTitlei =  Text("Informations");
                  }


                });
              } ,),
              if(actionIconi.icon == Icons.close)
                IconButton(
                    onPressed: () {
                      print('search button');
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
          ),],
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const <Widget>[Tab(text: 'Received'), Tab(text: 'Created')]),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Center(
          child: FutureBuilder<List<dynamic>>(
            future: fetchInfo(globals.login_id, 1),
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
                            'There are no Information ',
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
                }else
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                        ),
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          getInfobyid(context, _infoid(snapshot.data[index]), 1,
                              _imcount(snapshot.data[index]));
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                // backgroundColor: Colors.orange,
                                backgroundImage: NetworkImage(
                                    "https://www.hokybo.com/assets/Users/" +
                                        _creatorid(snapshot.data[index])
                                            .toString() +
                                        ".jpg"),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _rname(snapshot.data[index]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        _rolename(snapshot.data[index])
                                            .toLowerCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 9, color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _rcreatedtime(snapshot.data[index])
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        _rcreatedate(snapshot.data[index]),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                _rsubj(snapshot.data[index]),
                                style: GoogleFonts.poppins(fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Center(
          child: Container(
            child: FutureBuilder<List<dynamic>>(
              future: fetchInfo(globals.login_id, 0),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data.length == 0)
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
                              'There are no Informations ',
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
                  }else
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                    ),
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          getInfobyid(context, _infoid(snapshot.data[index]), 0,
                              _imcount(snapshot.data[index]));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert(_infoid(snapshot.data[index]));
                              });
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              // leading: CircleAvatar(
                              //   radius: 30,
                              //   backgroundColor: Colors.grey,
                              //   backgroundImage: NetworkImage("https://www.hokybo.com/assets/Users/" +_creatorid(snapshot.data[index]).toString() +".jpg"),
                              // ),
                              // title: Padding(
                              //   padding: const EdgeInsets.only(bottom: 8.0),
                              //   child: Text(
                              //     _rsubj(snapshot.data[index]),
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              // ),

                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _rsubj(snapshot.data[index]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _rname(snapshot.data[index]),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            GoogleFonts.poppins(fontSize: 11),
                                      ),
                                      Text(
                                        _rolename(snapshot.data[index])
                                            .toLowerCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _rcreatedtime(snapshot.data[index])
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black45),
                                      ),
                                      Text(
                                        _rcreatedate(snapshot.data[index]),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // subtitle: Text(_rname(snapshot.data[index])),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade700,
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => InformationCreate()));
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

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );

  Widget deleteeButton = TextButton(
    child: Text("Delete"),
    onPressed: () {},
  );

  Widget alert(int InfoID) {
    return AlertDialog(
      title: Text("Delete Information"),
      content: Text("Are you sure you want to delete this Information"),
      actions: [
        TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            }),
        TextButton(
          child: Text("Delete"),
          onPressed: () {
            deleteInfo(InfoID);
          },
        )
      ],
    );
  }

  deleteInfo(int infoid) {
    var Posturi =
        Uri.parse('https://www.hokybo.com/tms/api/Information/DeleteInfoByID');
    var request = http.MultipartRequest("POST", Posturi);
    request.fields['InfoID'] = infoid.toString();
    request.send().then((response) {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InformationView()));
      } else {
        Fluttertoast.showToast(
            msg: 'Error Occured',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);

        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }
}
