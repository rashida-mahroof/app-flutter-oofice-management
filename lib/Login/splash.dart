import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/connectivity.dart';
import 'package:untitled/Login/home.dart';
import 'package:untitled/Login/login.dart';
import 'package:untitled/Login/globals.dart' as globals;
import 'package:http/http.dart' as http;
import '../Model/users.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    checkConnection();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red[600],
      body: Center(
          child: Image.asset(
        'assets/img/keybot.png',
        width: 200,
      )),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) {
        return const ScreenLogin();
      }),
    );
  }

  Future<void> CheckUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    var _id = _sharedPrefs.getInt('PREF_ID');
    globals.login_id = _id!;

    if (_id == 0 || _id == null) {
      gotoLogin();
    } else {
      User user = User();
      var url = Uri.parse(
          'https://www.hokybo.com/tms/api/User/GetUserByID?UserID=' +
              _id.toString());
      final response = await http.get(url);
      var json1 = jsonDecode(response.body);
      user = User.fromJson(json1);
      print(user.isActive);
      if (user.isActive! > 0) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
      } else {
        gotoLogin();
      }
    }
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      var url = Uri.parse(
          'https://www.hokybo.com/tms/api/User/GetVersion?id=202.206.10');
      final response = await http.get(url);


      if(response.statusCode == 200)    //check version number
      {
        CheckUserLoggedIn();
        gotoLogin();
      }else{
        showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(

                content: Container(
                  height: 90,
                  child: Column(
                    children: [
                      Icon(Icons.warning,size: 50,color: Colors.yellow.shade600,),
                      SizedBox(height: 10,),
                      Text(
                        'Update Keybot to the latest version',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45),),

                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
            SystemNavigator.pop(),
                    child: const Text('Close'),
                  ),
                  // TextButton(
                  //   onPressed: (){},
                  //
                  //   child: const Text('Update'),
                  // ),
                ],
              ),
        );
      }

    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) {
          return const ConnectionError();
        }),
      );
      return 0;
    }
  }
}
