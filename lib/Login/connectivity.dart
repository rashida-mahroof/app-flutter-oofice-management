import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Login/splash.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Image.asset('assets/img/noint.png' ),
          ),
          SizedBox(
            height: 5,
          ),
          // Icon(
          //   Icons.wifi_off,
          //   color: Colors.black,
          //   size: 150,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Check Your Internet Connection and try again later',
              style: GoogleFonts.poppins(color: Colors.black45, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange.shade700),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Retry',style: GoogleFonts.poppins(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
              ))
        ],
      )),
    );
  }
}
