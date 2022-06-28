import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Prospectus/prospect-details.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;

import 'create-prospect.dart';

class ProspectsList extends StatefulWidget {
  const ProspectsList({Key? key}) : super(key: key);

  @override
  State<ProspectsList> createState() => _ProspectsListState();
}
Future<List<dynamic>> fetchProspect(int userid, int type) async {
  final String apiUrl =
      "https://www.hokybo.com/tms/api/Prospect/GetProspect?userid=" +
          userid.toString();
  var result = await http.get(Uri.parse(apiUrl));
  //rights=json.decode(result.body)['data']['Rights'][0].toString();
  return json.decode(result.body)['data'];
}
class _ProspectsListState extends State<ProspectsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prospects'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [

            Expanded(
              child: FutureBuilder(
                // future: ,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                    itemCount: 8,
                    itemBuilder: (BuildContext, index) {
                      return Card(
                        child: ListTile(
                          onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>prospectDetails()));
                          },
                          title: Row(
                            children: [
                              Text('12-02-2022',style: GoogleFonts.poppins(
                                  fontSize: 11, color: Colors.black54),)
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(1==2)  //if possibility is hot
                                Text(
                                  "HOT",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.green),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if(1==1) //if possibility is warm
                                Text(
                                  "WARM",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.yellow.shade800),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if(1==2) //if possibility is cold
                                Text(
                                  "COLD",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12, color: Colors.deepOrange),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                "Dr. Francis Chakko",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                    fontSize: 13, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Follow up on: 04-06-2022",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                          trailing: Column(
                            children: [
                             IconButton(onPressed: (){}, icon:  Icon(
                               Icons.call,
                               color: Colors.green,
                               size: 30,
                             ),),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProspect()));
        },
        tooltip: 'Create Prospects',
        child: Icon(
          Icons.add,
          size: 30,
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
