import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Logistics/create-trip.dart';
import 'package:untitled/Logistics/trip-details.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'DetailsShow.dart';

class TripsList extends StatefulWidget {
  const TripsList({Key? key}) : super(key: key);
  @override
  State<TripsList> createState() => _TripsListState();
}
int _TripID(dynamic user) {
  return user['TripId'];
}
String _Up_RouteNo(dynamic user) {
  return user['Up_RouteNo'];
}
String _Down_RouteNo(dynamic user) {
  return user['Down_RouteNo'];
}
String _Up_date(dynamic user){
  return user['Up_dates'];
}
String _Down_date(dynamic user){
  return user['Down_dates'];
}
  Future<List<dynamic>> fetchTrip() async {
    const String apiUrl ="https://www.hokybo.com/tms/api/Trip/GetAllDetails";

    var result = await http.get(Uri.parse(apiUrl));

    return json.decode(result.body);
  }
var detaildata;
late List<String>? Vehi = [];
late List<String>? Driv = [];
late List<String>? RouteU = [];
late List<String>? RouteD = [];
class _TripsListState extends State<TripsList> {
  SamplePostClass Obj1 = SamplePostClass();
  getItemAndNavigate(int index, BuildContext context) async {
    var response2 = await http.get(Uri.parse(
        "https://www.hokybo.com/tms/api/Trip/GetAllDetailsByID?TripId=" +
            index.toString()+'&UserId='+globals.login_id.toString()));
    if (response2.statusCode == 200) {
      detaildata = json.decode(response2.body)['data'];
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context1) => TripDetails(Obj: detaildata)));
    }
  }
  @override
  Widget build(BuildContext context) {
    IntiaGetVeh();
    IntiaGetDri();
    IntiaGetRoute();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Created Trips'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: FutureBuilder(
           future:fetchTrip() ,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext, index) {
          return GestureDetector(
            onTap: () {
              getItemAndNavigate(
                  _TripID(snapshot.data[index]), context);
            },
            child: Card(
              child: ListTile(
                title: Text(
                  "Trip Id: V" + _TripID(snapshot.data[index]).toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: Colors.black54),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Route up: "+ _Up_date(snapshot.data[index])+" | "+_Up_RouteNo(snapshot.data[index]),
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Route down: "+_Down_date(snapshot.data[index])+" | "+_Down_RouteNo(snapshot.data[index]),
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                leading: Icon(
                  Icons.download_done_rounded,
                  color: Colors.green,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    } },

        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade900,
        onPressed: () {
          if(1==1){ Navigator.push(
              context, MaterialPageRoute(builder: ((context) => CreateTrip())));
        }},
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        tooltip: 'Create a trip',
      ),
    );
  }

  IntiaGetVeh() {
    void Getvehi() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/GetVeh'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        Vehi!.clear();
        //RoleList = [];
        int length = datalist.length;
        if (Vehi!.length <= 1) {
          for (int i = 0; i < length; i++) {
            Vehi!.add(datalist[i]['VehicleNum'].toString());
          }
        }
      }
    }
    Getvehi();
    return Vehi;
  }
  IntiaGetDri() {
    void GetDri() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/GetDrive'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        Driv!.clear();

        int length = datalist.length;
        if (Vehi!.length <= 1) {
          for (int i = 0; i < length; i++) {
            Driv!.add(datalist[i]['DriverNum'].toString());
          }
        }
      }
    }
    GetDri();
    return Driv;
  }
  IntiaGetRoute() {
    void GetRoute() async {
      final response = await http.get(Uri.parse(
          'https://www.hokybo.com/tms/api/Trip/GetRoute'));
      final List<dynamic> datalist;
      if (response.statusCode == 200) {
        datalist = jsonDecode(response.body);
        RouteU!.clear();
        RouteD!.clear();
        int length = datalist.length;
        if (Vehi!.length <= 1) {
          for (int i = 0; i < length; i++) {
            RouteU!.add(datalist[i]['Up_RouteNam'].toString());
            RouteD!.add(datalist[i]['Down_RouteNo'].toString());
          }
        }
      }
    }
    GetRoute();
    return Route;
  }
}
