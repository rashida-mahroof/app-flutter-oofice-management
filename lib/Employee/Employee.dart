import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'EmployeeDetails.dart';
import 'package:untitled/Login/globals.dart' as globals;

class EmployeeView extends StatefulWidget {
  const EmployeeView({Key? key}) : super(key: key);

  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

Future<List<dynamic>> fetchInfo() async {
  String apiUrl =
      'https://www.hokybo.com/tms/api/Employee/GetEmployee?UserID=' +
          globals.login_id.toString() +
          "&i=1";
  var result = await http.get(Uri.parse(apiUrl));

  return json.decode(result.body);
}

getEmployeebyid(BuildContext ctx, int EmployeeID) {
  Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (ctx) => EmployeeById(EmployeeID: EmployeeID)));
}

String _Ename(dynamic user) {
  return user['Name'];
}

int _Employeeid(dynamic user) {
  return user['UserID'];
}

String _Erole(dynamic user) {
  return user['Role'];
}

class _EmployeeViewState extends State<EmployeeView>
    with TickerProviderStateMixin {
  Widget appBarTitlem =  const Text("Members");
  Icon actionIconm =  const Icon(Icons.search);
  Widget build(BuildContext context) {
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
          // centerTitle: true,
          title:appBarTitlem,

          actions: <Widget>[
            Row(
              children: [
                IconButton(icon: actionIconm,onPressed:(){
                  setState(() {
                    if ( actionIconm.icon == Icons.search){
                      actionIconm =  const Icon(Icons.close);
                      appBarTitlem = const TextField(
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
                      actionIconm =  Icon(Icons.search);
                      appBarTitlem =  Text("Members");
                    }


                  });
                } ,),
                if(actionIconm.icon == Icons.close)
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
        ),
        body: Center(
          child: FutureBuilder<List<dynamic>>(
            future: fetchInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          getEmployeebyid(
                              context, _Employeeid(snapshot.data[index]));
                        },
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "https://www.hokybo.com/assets/Users/" +
                                      _Employeeid(snapshot.data[index])
                                          .toString() +
                                      ".jpg?",
                                ),
                              ),
                              title: Text(
                                _Ename(snapshot.data[index]),
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black),
                              ),
                              subtitle: Text(
                                _Erole(snapshot.data[index]),
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: Colors.black38),
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
        ));
  }

  void redirecttohome(BuildContext context) async {
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
