// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:media_scanner/media_scanner.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class MyHomePagetest extends StatefulWidget {
//   @override
//   _MyHomePagetestState createState() => _MyHomePagetestState();
// }
//
// class _MyHomePagetestState extends State<MyHomePagetest> {
//   final Dio dio = Dio();
//   bool loading = false;
//   double progress = 0;
//
//   Future<bool> saveVideo(String url, String fileName) async {
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage) &&
//             await _requestPermission(Permission.accessMediaLocation) &&
//             await _requestPermission(Permission.manageExternalStorage)) {
//           directory = (await getExternalStorageDirectory())!;
//           String newPath = "";
//           print(directory);
//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/KeyBot";
//           directory = Directory(newPath);
//           String? loadMediaMessage;
//           // Platform messages may fail, so we use a try/catch PlatformException.
//           try {
//             loadMediaMessage = await MediaScanner.loadMedia(path: newPath);
//           } on PlatformException {
//             loadMediaMessage = 'Failed to get platform version.';
//             print(loadMediaMessage);
//           }
//         } else {
//           return false;
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getTemporaryDirectory();
//         } else {
//           return false;
//         }
//       }
//       File saveFile = File(directory.path + "/$fileName");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await dio.download(url, saveFile.path,
//             onReceiveProgress: (value1, value2) {
//           setState(() {
//             progress = value1 / value2;
//           });
//         });
//         if (Platform.isIOS) {
//           await ImageGallerySaver.saveFile(saveFile.path,
//               isReturnPathOfIOS: true);
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   downloadFile() async {
//     setState(() {
//       loading = true;
//       progress = 0;
//     });
//     bool downloaded = await saveVideo(
//         "https://www.hokybo.com/assets/UploadFiles/114/1.jpg", "image45.jpg");
//     if (downloaded) {
//       print("File Downloaded");
//     } else {
//       print("Problem Downloading File");
//     }
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: loading
//             ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: LinearProgressIndicator(
//                   minHeight: 10,
//                   value: progress,
//                 ),
//               )
//             : FlatButton.icon(
//                 icon: Icon(
//                   Icons.download_rounded,
//                   color: Colors.white,
//                 ),
//                 color: Colors.blue,
//                 onPressed: downloadFile,
//                 padding: const EdgeInsets.all(10),
//                 label: Text(
//                   "Download file",
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 )),
//       ),
//     );
//   }
// }
//
// // import 'package:dio/dio.dart';
// // import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// // import 'package:flutter/material.dart';
// // import 'package:permission_handler/permission_handler.dart';
// //
// //
// // class Home extends  StatefulWidget {
// //   @override
// //   State<Home> createState() => _HomeState();
// // }
// //
// // class _HomeState extends State<Home> {
// //
// //   String imgurl = "https://www.fluttercampus.com/img/banner.png";
// //   //you can save video files too.
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         resizeToAvoidBottomInset: false,
// //         appBar: AppBar(
// //           title: Text("Download Image from URL"),
// //           backgroundColor: Colors.deepPurpleAccent,
// //         ),
// //         body: Container(
// //           child: Column(
// //             children: [
// //               Image.network(imgurl, height: 150,),
// //               Divider(),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   Map<Permission, PermissionStatus> statuses = await [
// //                     Permission.storage,
// //                     //add more permission to request here.
// //                   ].request();
// //
// //                   if(statuses[Permission.storage]!.isGranted){
// //                     var dir = await DownloadsPathProvider.downloadsDirectory;
// //                     if(dir != null){
// //                       String savename = "banner.png";
// //                       String savePath = dir.path + "/$savename";
// //                       print(savePath);
// //                       //output:  /storage/emulated/0/Download/banner.png
// //
// //                       try {
// //                         await Dio().download(
// //                             imgurl,
// //                             savePath,
// //                             onReceiveProgress: (received, total) {
// //                               if (total != -1) {
// //                                 print((received / total * 100).toStringAsFixed(0) + "%");
// //                                 //you can build progressbar feature too
// //                               }
// //                             });
// //                         print("Image is saved to download folder.");
// //                       } on DioError catch (e) {
// //                         print(e.message);
// //                       }
// //                     }
// //                   }else{
// //                     print("No permission to read and write.");
// //                   }
// //
// //                 },
// //                 child: Text("Save Image on Gallery."),
// //               )
// //
// //             ],
// //           ),
// //         )
// //     );
// //   }
// // }
// //
// //
// //
// // // import 'package:animated_custom_dropdown/custom_dropdown.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // //
// // // class MyHomePageq extends StatefulWidget {
// // //   MyHomePageq({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   _MyHomePageqState createState() => _MyHomePageqState();
// // // }
// // //
// // // class _MyHomePageqState extends State<MyHomePageq> {
// // //   List<Widget> _cardList = [];
// // //   final sizeController = TextEditingController();
// // //   final prodController = TextEditingController();
// // //   final materialController = TextEditingController();
// // //   final PriceController = TextEditingController();
// // //   void _addCardWidget() {
// // //     setState(() {
// // //       _cardList.add(_card());
// // //     });
// // //   }
// // //   Widget _card() {
// // //     return Column(
// // //       children: [
// // //         Row(
// // //           children: [
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text('Product',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black54),),
// // //                   Container(
// // //                     decoration: BoxDecoration(
// // //                         border: Border.all(color: Colors.orange)
// // //                     ),
// // //                     child: CustomDropdown(
// // //                       hintText: 'Select product',
// // //                       items: ['sofa','cot','chair','Wardrobe','divan'],
// // //                       controller: prodController,
// // //                       excludeSelected: false,
// // //                       fillColor: Colors.white,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             SizedBox(width: 10,),
// // //             Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Price',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black54),),
// // //                     Container(
// // //                       decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.orange)
// // //                       ),
// // //                       child: CustomDropdown(
// // //                         hintText: 'Select Price',
// // //                         items: ['1k-2k','5k-6k','10k-15k','15k-20k'],
// // //                         controller: PriceController,
// // //                         excludeSelected: false,
// // //                         fillColor: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 )
// // //             )
// // //           ],
// // //         ),
// // //         SizedBox(height: 10,),
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.start,
// // //           children: [
// // //             Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Size',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black54),),
// // //                     Container(
// // //                       decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.orange)
// // //                       ),
// // //                       child: CustomDropdown(
// // //                         hintText: 'Select Size',
// // //                         items: ['12 inch','8 inch','6:8','12:678'],
// // //                         controller: sizeController,
// // //                         excludeSelected: false,
// // //                         fillColor: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ],)),
// // //             SizedBox(width: 10,),
// // //             Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text('Material',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black54),),
// // //                     Container(
// // //                       decoration: BoxDecoration(
// // //                           border: Border.all(color: Colors.orange)
// // //                       ),
// // //                       child: CustomDropdown(
// // //                         hintText: 'Select material',
// // //                         items: ['Cloth','mahagony','teak','wood'],
// // //                         controller: materialController,
// // //                         excludeSelected: false,
// // //                         fillColor: Colors.white,
// // //                       ),
// // //                     ),
// // //                   ],))
// // //           ],
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //   @override
// // //   Widget build(BuildContext context) {
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         // Here we take the value from the MyHomePage object that was created by
// // //         // the App.build method, and use it to set our appbar title.
// // //         title: Text("Add Widget Dynamically"),
// // //       ),
// // //       body: Center(
// // //         // Center is a layout widget. It takes a single child and positions it
// // //         // in the middle of the parent.
// // //         child: ListView.builder(
// // //             itemCount: _cardList.length,
// // //             itemBuilder: (context,index){
// // //               return _cardList[index];
// // //             }),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _addCardWidget,
// // //         tooltip: 'Add',
// // //         child: Icon(Icons.add),
// // //       ), // This trailing comma makes auto-formatting nicer for build methods.
// // //     );
// // //   }
// // // }
