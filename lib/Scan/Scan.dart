import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Scan/scan-history.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'Productdetail.dart';
import 'package:untitled/Login/globals.dart' as globals;

class ScanApp extends StatefulWidget {
  @override
  _ScanAppState createState() => _ScanAppState();
}

class _ScanAppState extends State<ScanApp> {
  String _scanBarcode = 'Unknown';
  List Probar = [];
  List Procode = [];
  final TextEditingController _barcodename = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    var detaildata;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      var response2 = await http.get(Uri.parse(
          "https://www.hokybo.com/tms/api/Scan/GetProductCode?BarCode=" +
              barcodeScanRes.toString()));
      if (response2.statusCode == 200) {
        detaildata = json.decode(response2.body);
        print(detaildata);
        globals.Code = detaildata[0]['ProductCode'];
      }
      if (barcodeScanRes != '-1') {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WebViewExample()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Colors.orangeAccent.shade700),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Text(
                                            'Product Details',
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          this.setState(() {
                                          bool pr= Probar.contains(barcodeScanRes);
                                          if(pr==false) {
                                            Procode.add(
                                                detaildata[0]['ProductCode']);
                                            Probar.add(barcodeScanRes);
                                          }
                                          else
                                            {
                                              Fluttertoast.showToast(
                                                  msg: 'Already added',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white);
                                            }
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Colors.blueAccent.shade700),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Text(
                                            'Save Barcode',
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Barcode scan'),
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
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanHistory()));
                      },
                      tooltip: 'Scan History',
                      icon: Icon(Icons.history)),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (BuildContext context) {
                return Container(
                    // alignment: Alignment.center,
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   new BoxShadow(
                            //     color: Color.fromARGB(255, 206, 206, 206),
                            //     blurRadius: 8.0,
                            //   ),
                            // ],
                            color: Colors.white60),
                        child: GestureDetector(
                          onTap: () {
                            scanBarcodeNormal();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Image.asset('assets/img/bar.png'),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          scanBarcodeNormal();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.orange.shade700,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            'Scan',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12),
                      //       boxShadow: [
                      //         new BoxShadow(
                      //           color: Color.fromARGB(255, 208, 208, 210),
                      //           blurRadius: 8.0,
                      //         ),
                      //       ],
                      //       color: Colors.grey.shade200),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 70),
                      //         child: Image.asset('assets/img/qr.png'),
                      //       ),
                      //       ElevatedButton(
                      //           onPressed: () {
                      //             startBarcodeScanStream();
                      //           },
                      //           child: Text('Start QR Scanning'),
                      //           style: ButtonStyle(
                      //               shape: MaterialStateProperty.all<
                      //                       RoundedRectangleBorder>(
                      //                   RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(18.0),
                      //                       side: BorderSide(
                      //                           color: Colors.white60)))))
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                )
                    // child: Flex(
                    //     direction: Axis.vertical,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       ElevatedButton(
                    //           onPressed: () => scanBarcodeNormal(),
                    //           child: Text('barcode scan'),
                    //       ),
                    //       ElevatedButton(
                    //           onPressed: () => scanQR(), child: Text('QR scan')),
                    //       //ElevatedButton(
                    //       //   onPressed: () => startBarcodeScanStream(),
                    //       //   child: Text('Start barcode scan stream')),
                    //       // Text('Scan result : $_scanBarcode\n',
                    //       //     style: TextStyle(fontSize: 20))
                    //     ])
                    );
              }),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _barcodename,
                            decoration: InputDecoration(
                                hintText: 'Type Name to save',
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black45),
                                focusColor: Colors.deepOrange),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Procode.clear();
                              Probar.clear();
                              _barcodename.clear();
                              });
                              
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue),
                            child: Text('Clear')),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
SaveBarcodes();


                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            child: Text('Save')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (int i =Probar.length-1; i >=0; i--)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Barcode',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black54),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      Probar[i].toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Code',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black54),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Text(
                                      Procode[i].toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    Probar.remove(Probar[i]);
                                  Procode.remove(Procode[i]);
                                  });
                                  
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
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

SaveBarcodes()async{
//   Map<String,String>data;
//   data={
//      'BarcodeName':_barcodename.text
//     };
//     for(int i=0;i<Procode.length;i++){
//  data.addAll({'ProductCode$i':Procode[i]});
// }

// for(int i=0;i<Probar.length;i++){
//  data.addAll({'BarCode$i':Probar[i]});
// }
// print(data);
//  http.Response response = await http.post(
//    Uri.parse('uri'),
//    body:data,
//    );

var Posturi = Uri.parse(
                            'https://www.hokybo.com/tms/api/Scan/Post');
                        var request = http.MultipartRequest("POST", Posturi);
                         for(int i=0;i<Probar.length;i++){
                           String b="BarCode"+i.toString();
request.fields[b] = Probar[i];
                        }

                        for(int i=0;i<Procode.length;i++){
                          String p="ProductCode"+i.toString();
request.fields[p] = Procode[i];
                        }
                        request.fields['Count'] = Procode.length.toString();
                        request.fields['BarcodeName'] = _barcodename.text;
                        request.fields['CreaterID'] =
                            globals.login_id.toString();

                        request.send().then((response) {
                          if (response.statusCode == 201) {
                            Fluttertoast.showToast(
                                msg: 'Saved Successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white);
                                setState(() {
                                  Probar.clear();
                                  Procode.clear();
                                  _barcodename.clear();
                                });

                            // Navigator.pushReplacement(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             InformationView()));
                          } else if(response.statusCode == 406) {
                            Fluttertoast.showToast(
                                msg: 'Name Already exists',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white);
                          }else{
                            Fluttertoast.showToast(
                                msg: 'Error occured',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white);
                          }
                        });
   

}
  

}
