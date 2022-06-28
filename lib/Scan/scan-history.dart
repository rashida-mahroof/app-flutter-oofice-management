import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Scan/Scan.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'package:untitled/Login/globals.dart' as globals;
class ScanHistory extends StatefulWidget {
  const ScanHistory({Key? key}) : super(key: key);

  @override
  State<ScanHistory> createState() => _ScanHistoryState();
}
Future<List<dynamic>> fetchHistory(int userid) async {
  final String apiUrl =
      "https://www.hokybo.com/tms/api/scan/GetHistory?UserID="+userid.toString();
  var result = await http.get(Uri.parse(apiUrl));
  //rights=json.decode(result.body)['data']['Rights'][0].toString();
  return json.decode(result.body);
}

String _rname(dynamic user) {
  return user['BarcodeName'];
}
class _ScanHistoryState extends State<ScanHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Scan History'),
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
      body: Center(
        
        child:FutureBuilder<List<dynamic>>(
          future: fetchHistory(globals.login_id),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData)
            {
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
                }
                else
                {
                  return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
          child: ListView.builder(
            itemCount: snapshot.data.length,
              itemBuilder:( BuildContext context,index){
                return Card(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanApp()));
                    },
                    child: ListTile(
                      title:

                          Text(_rname(snapshot.data[index]),
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),


                      trailing: IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext context)=>
                              AlertDialog(
                               content: Text('Do you want to delete ?'),
                               actions: [
                                 TextButton(
                                     onPressed: (){

                                       Navigator.pop(context);
                                     },
                                     child: Text('Cancel')),
                                 TextButton(onPressed: (){
                                   DeleteHist(_rname(snapshot.data[index]));
                                   Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScanHistory()));
                                 }, child: Text('Delete'))
                               ],
                             )
                            );
                          },
                          icon: Icon(Icons.delete_sharp,color: Colors.deepOrange,)),
                    ),
                  ),
                );

              }),
        );
                }
            }
            else
            {
               return Center(child: CircularProgressIndicator());
            }
          },
        )
        
        
         
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


  

 

DeleteHist(String histname) {
    var Posturi =
        Uri.parse('https://www.hokybo.com/tms/api/Scan/DeleteHistory');
    var request = http.MultipartRequest("POST", Posturi);
    request.fields['ScanHistoryName'] = histname;
    request.send().then((response) {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanHistory()));
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
