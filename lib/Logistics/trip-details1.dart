//import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:untitled/Logistics/stepper.dart';
import 'edit-trip.dart';

class TripDetails1 extends StatefulWidget {
  const TripDetails1({Key? key}) : super(key: key);

  @override
  State<TripDetails1> createState() => _TripDetails1State();
}

Color _initialColor = Colors.yellow.shade700;
bool _isVisible = true;

class _TripDetails1State extends State<TripDetails1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip ID: V234567'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditTrip()));
                },
                tooltip: 'Edit Trip',
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 25,
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Container(
                        height: 90,
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: 50,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Why are you deleting this Trip ?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Delete Trip',
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle No',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Colors.orange.shade500),
                    ),
                    Text(
                      'V234567890',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: Colors.orange.shade500),
                    ),
                    Text('Yadhu Krishna',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    // ButtonsTabBar(
                    //   backgroundColor: Colors.orange.shade800,
                    //   unselectedBackgroundColor: Colors.grey[300],
                    //   unselectedLabelStyle: TextStyle(color: Colors.black),
                    //   labelStyle: TextStyle(
                    //       color: Colors.white, fontWeight: FontWeight.bold),
                    //   tabs: [
                    //     Tab(
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(right: 20, left: 10),
                    //         child: Icon(
                    //           Icons.alt_route,
                    //           size: 35,
                    //         ),
                    //       ),
                    //       text: "Trip Up",
                    //     ),
                    //     Tab(
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(left: 10, right: 20),
                    //         child: Icon(
                    //           Icons.route,
                    //           size: 35,
                    //         ),
                    //       ),
                    //       text: "Trip Down",
                    //     ),
                    //   ],
                    // ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.orange.shade200),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 6),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      Icons.calendar_month,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  Text('Started on: ',
                                                      style: GoogleFonts.poppins(
                                                          //color: Colors.white,
                                                          fontSize: 11,
                                                          color: Colors.black54),
                                                      textAlign:
                                                          TextAlign.justify),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('10:37 AM',
                                                      style: GoogleFonts.poppins(
                                                        //color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify),
                                                  Text('28 Sat 2022',
                                                      style: GoogleFonts.poppins(
                                                        //color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: Icon(
                                                      Icons.local_shipping,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  Text('Space Status:',
                                                      style: GoogleFonts.poppins(
                                                          //color: Colors.white,
                                                          fontSize: 11,
                                                          color: Colors.black54),
                                                      textAlign:
                                                          TextAlign.justify),
                                                ],
                                              ),
                                              Text(
                                                '75% vacant',
                                                style: GoogleFonts.poppins(
                                                  //color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          for(int i = 1;i<8 ; i++)
                                          Container(
                                            child: Column(
                                              children: [

                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: Colors.grey,
                                                ),
                                                // --------------if trip not started-------------------
                                                                  if(1==2)
                                                                    Container(
                                                                      height: 75,
                                                                      width: 75,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.grey.shade300,width: 2),
                                                                          color: Colors.yellow.shade700,
                                                                          borderRadius: BorderRadius.circular(50)
                                                                      ),
                                                                      child: Center(
                                                                        child: TextButton(onPressed: () {
                                                                          setState(() {
                                                                            // _initialColor = Colors.green;
                                                                            // _isVisible = !_isVisible;
                                                                          });
                                                                        },
                                                                          child: Text('START TRIP',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                                                                      ),
                                                                    ),
                                                                  //--------------if started-------------------


                                                if(1==2)
                                                                    Container(
                                                                      height: 75,
                                                                      width: 75,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.grey.shade300,width: 2),
                                                                          color: Colors.green.shade700,
                                                                          borderRadius: BorderRadius.circular(50)
                                                                      ),
                                                                      child: Center(
                                                                        child: TextButton(onPressed: () {
                                                                          setState(() {
                                                                            // _initialColor = Colors.green;
                                                                            // _isVisible = !_isVisible;
                                                                          });
                                                                        },
                                                                          child: Text('STARTED',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                                                                      ),
                                                                    ),
                                                                  //--------------if reached at branch-------------------
                                                                  if(1==1)
                                                                    Container(
                                                                      height: 75,
                                                                      width: 75,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.grey.shade300,width: 2),
                                                                          color: Colors.blueAccent.shade700,
                                                                          borderRadius: BorderRadius.circular(50)
                                                                      ),
                                                                      child: Center(
                                                                        child: TextButton(onPressed: () {
                                                                          showDialog<String>(
                                                                            context: context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(

                                                                                  content: Container(
                                                                                    height: 100,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Icon(Icons.cloud_done,size: 50,color: Colors.green,),
                                                                                        SizedBox(height: 10,),
                                                                                        Text(
                                                                                          'Do you want to Verify this Trip ?',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45),),


                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      onPressed: () =>
                                                                                          Navigator.pop(
                                                                                              context, 'Cancel'),
                                                                                      child: const Text('Cancel'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: (){},

                                                                                      child: const Text('Verify'),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                          );
                                                                          setState(() {

                                                                            // _initialColor = Colors.green;
                                                                            // _isVisible = !_isVisible;
                                                                          });
                                                                        },
                                                                          child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                                                                      ),
                                                                    ),
                                                                  //--------------if reached at branch & verified by BM-------------------
                                                                  if(1==2)
                                                                    Container(
                                                                      height: 75,
                                                                      width: 75,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.grey.shade300,width: 2),
                                                                          color: Colors.teal,
                                                                          borderRadius: BorderRadius.circular(50)
                                                                      ),
                                                                      child: Center(
                                                                        child: TextButton(onPressed: () {
                                                                          setState(() {
                                                                            // _initialColor = Colors.green;
                                                                            // _isVisible = !_isVisible;
                                                                          });
                                                                        },
                                                                          child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                                                                      ),
                                                                    ),
                                                                  //--------------if Trip end-------------------
                                                                  if(1==2)
                                                                    Container(
                                                                      height: 75,
                                                                      width: 75,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: Colors.grey.shade300,width: 2),
                                                                          color: Colors.deepOrange,
                                                                          borderRadius: BorderRadius.circular(50)
                                                                      ),
                                                                      child: Center(
                                                                        child: TextButton(onPressed: () {
                                                                          setState(() {
                                                                            // _initialColor = Colors.green;
                                                                            // _isVisible = !_isVisible;
                                                                          });
                                                                        },
                                                                          child: Text('End',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                                                                      ),
                                                                    ),
                                                                  Container(
                                                                    width: 2,
                                                                    height: 50,
                                                                    color: Colors.black26,
                                                                    // color: index == totaldatacount.length-1 == 0 ? Colors.white : Colors.black26,
                                                                  ),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    top: -5,
                                    child: Container(
                                        color: Colors.grey[50],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'Trip Up',
                                            style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                color: Colors.orange.shade500),
                                          ),
                                        )),
                                  )
                                ],
                              ),

                              // ListView.builder(
                              //     itemCount:10,
                              //     itemBuilder: (context,index){
                              //       return Container(
                              //           child: Row(
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             children: [
                              //
                              //               Column(
                              //                 children: [
                              //                   Container(
                              //                     width: 2,
                              //                     height: 50,
                              //                     color: index == 0 ? Colors.white30 : Colors.black26,
                              //                   ),
                              //                   //--------------if trip not started-------------------
                              //                   if(1==2)
                              //                     Container(
                              //                       height: 75,
                              //                       width: 75,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                              //                           color: Colors.yellow.shade700,
                              //                           borderRadius: BorderRadius.circular(50)
                              //                       ),
                              //                       child: Center(
                              //                         child: TextButton(onPressed: () {
                              //                           setState(() {
                              //                             // _initialColor = Colors.green;
                              //                             // _isVisible = !_isVisible;
                              //                           });
                              //                         },
                              //                           child: Text('START TRIP',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                              //                       ),
                              //                     ),
                              //                   //--------------if started-------------------
                              //                   if(1==2)
                              //                     Container(
                              //                       height: 75,
                              //                       width: 75,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                              //                           color: Colors.green.shade700,
                              //                           borderRadius: BorderRadius.circular(50)
                              //                       ),
                              //                       child: Center(
                              //                         child: TextButton(onPressed: () {
                              //                           setState(() {
                              //                             // _initialColor = Colors.green;
                              //                             // _isVisible = !_isVisible;
                              //                           });
                              //                         },
                              //                           child: Text('STARTED',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                              //                       ),
                              //                     ),
                              //                   //--------------if reached at branch-------------------
                              //                   if(1==1)
                              //                     Container(
                              //                       height: 75,
                              //                       width: 75,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                              //                           color: Colors.blueAccent.shade700,
                              //                           borderRadius: BorderRadius.circular(50)
                              //                       ),
                              //                       child: Center(
                              //                         child: TextButton(onPressed: () {
                              //                           showDialog<String>(
                              //                             context: context,
                              //                             builder: (BuildContext context) =>
                              //                                 AlertDialog(
                              //
                              //                                   content: Container(
                              //                                     height: 100,
                              //                                     child: Column(
                              //                                       children: [
                              //                                         Icon(Icons.cloud_done,size: 50,color: Colors.green,),
                              //                                         SizedBox(height: 10,),
                              //                                         Text(
                              //                                           'Do you want to Verify this Trip ?',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45),),
                              //
                              //
                              //                                       ],
                              //                                     ),
                              //                                   ),
                              //                                   actions: <Widget>[
                              //                                     TextButton(
                              //                                       onPressed: () =>
                              //                                           Navigator.pop(
                              //                                               context, 'Cancel'),
                              //                                       child: const Text('Cancel'),
                              //                                     ),
                              //                                     TextButton(
                              //                                       onPressed: (){},
                              //
                              //                                       child: const Text('Verify'),
                              //                                     ),
                              //                                   ],
                              //                                 ),
                              //                           );
                              //                           setState(() {
                              //
                              //                             // _initialColor = Colors.green;
                              //                             // _isVisible = !_isVisible;
                              //                           });
                              //                         },
                              //                           child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                              //                       ),
                              //                     ),
                              //                   //--------------if reached at branch & verified by BM-------------------
                              //                   if(1==2)
                              //                     Container(
                              //                       height: 75,
                              //                       width: 75,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                              //                           color: Colors.teal,
                              //                           borderRadius: BorderRadius.circular(50)
                              //                       ),
                              //                       child: Center(
                              //                         child: TextButton(onPressed: () {
                              //                           setState(() {
                              //                             // _initialColor = Colors.green;
                              //                             // _isVisible = !_isVisible;
                              //                           });
                              //                         },
                              //                           child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                              //                       ),
                              //                     ),
                              //                   //--------------if Trip end-------------------
                              //                   if(1==2)
                              //                     Container(
                              //                       height: 75,
                              //                       width: 75,
                              //                       decoration: BoxDecoration(
                              //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                              //                           color: Colors.deepOrange,
                              //                           borderRadius: BorderRadius.circular(50)
                              //                       ),
                              //                       child: Center(
                              //                         child: TextButton(onPressed: () {
                              //                           setState(() {
                              //                             // _initialColor = Colors.green;
                              //                             // _isVisible = !_isVisible;
                              //                           });
                              //                         },
                              //                           child: Text('End',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                              //                       ),
                              //                     ),
                              //                   Container(
                              //                     width: 2,
                              //                     height: 50,
                              //                     color: Colors.black26,
                              //                     // color: index == totaldatacount.length-1 == 0 ? Colors.white : Colors.black26,
                              //                   ),
                              //
                              //                 ],
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.only(left: 15),
                              //                 child: Visibility(
                              //                   visible:true,
                              //                   child: Container(
                              //                     child: Column(
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text('10:32 AM',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45),),
                              //                         Text('27-April-2022',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black54)),
                              //                         Text('Verified',style: GoogleFonts.poppins(fontSize: 13,color: Colors.green,fontWeight: FontWeight.w600)),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               )
                              //
                              //             ],
                              //           )
                              //       );
                              //     }),
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.orange.shade200),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 6),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                                Text('Started on: ',
                                                    style: GoogleFonts.poppins(
                                                        //color: Colors.white,
                                                        fontSize: 11,
                                                        color: Colors.black54),
                                                    textAlign:
                                                        TextAlign.justify),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('10:37 AM',
                                                    style: GoogleFonts.poppins(
                                                      //color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify),
                                                Text('28 Sat 2022',
                                                    style: GoogleFonts.poppins(
                                                      //color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Icon(
                                                    Icons.local_shipping,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                                Text('Space Status:',
                                                    style: GoogleFonts.poppins(
                                                        //color: Colors.white,
                                                        fontSize: 11,
                                                        color: Colors.black54),
                                                    textAlign:
                                                        TextAlign.justify),
                                              ],
                                            ),
                                            Text('75% vacant',
                                                style: GoogleFonts.poppins(
                                                  //color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.justify),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  top: -5,
                                  child: Container(
                                      color: Colors.grey[50],
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          'Trip Down',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.orange.shade500),
                                        ),
                                      )),
                                )
                              ],
                            ),

                            // ListView.builder(
                            //     itemCount:5,
                            //     itemBuilder: (context,index){
                            //       return Container(
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.center,
                            //             children: [
                            //
                            //               Column(
                            //                 children: [
                            //                   Container(
                            //                     width: 2,
                            //                     height: 50,
                            //                     color: index == 0 ? Colors.white30 : Colors.black26,
                            //                   ),
                            //                   //--------------if trip not started-------------------
                            //                   if(1==2)
                            //                     Container(
                            //                       height: 75,
                            //                       width: 75,
                            //                       decoration: BoxDecoration(
                            //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                            //                           color: Colors.yellow.shade700,
                            //                           borderRadius: BorderRadius.circular(50)
                            //                       ),
                            //                       child: Center(
                            //                         child: TextButton(onPressed: () {
                            //                           setState(() {
                            //                             // _initialColor = Colors.green;
                            //                             // _isVisible = !_isVisible;
                            //                           });
                            //                         },
                            //                           child: Text('START TRIP',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                            //                       ),
                            //                     ),
                            //                   //--------------if started-------------------
                            //                   if(1==2)
                            //                     Container(
                            //                       height: 75,
                            //                       width: 75,
                            //                       decoration: BoxDecoration(
                            //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                            //                           color: Colors.green.shade700,
                            //                           borderRadius: BorderRadius.circular(50)
                            //                       ),
                            //                       child: Center(
                            //                         child: TextButton(onPressed: () {
                            //                           setState(() {
                            //                             // _initialColor = Colors.green;
                            //                             // _isVisible = !_isVisible;
                            //                           });
                            //                         },
                            //                           child: Text('STARTED',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                            //                       ),
                            //                     ),
                            //                   //--------------if reached at branch-------------------
                            //                   if(1==1)
                            //                     Container(
                            //                       height: 75,
                            //                       width: 75,
                            //                       decoration: BoxDecoration(
                            //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                            //                           color: Colors.blueAccent.shade700,
                            //                           borderRadius: BorderRadius.circular(50)
                            //                       ),
                            //                       child: Center(
                            //                         child: TextButton(onPressed: () {
                            //                           showDialog<String>(
                            //                             context: context,
                            //                             builder: (BuildContext context) =>
                            //                                 AlertDialog(
                            //
                            //                                   content: Container(
                            //                                     height: 100,
                            //                                     child: Column(
                            //                                       children: [
                            //                                         Icon(Icons.cloud_done,size: 50,color: Colors.green,),
                            //                                         SizedBox(height: 10,),
                            //                                         Text(
                            //                                           'Do you want to Verify this Trip ?',textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 14,color: Colors.black45),),
                            //
                            //
                            //                                       ],
                            //                                     ),
                            //                                   ),
                            //                                   actions: <Widget>[
                            //                                     TextButton(
                            //                                       onPressed: () =>
                            //                                           Navigator.pop(
                            //                                               context, 'Cancel'),
                            //                                       child: const Text('Cancel'),
                            //                                     ),
                            //                                     TextButton(
                            //                                       onPressed: (){},
                            //
                            //                                       child: const Text('Verify'),
                            //                                     ),
                            //                                   ],
                            //                                 ),
                            //                           );
                            //                           setState(() {
                            //                             // _initialColor = Colors.green;
                            //                             // _isVisible = !_isVisible;
                            //                           });
                            //                         },
                            //                           child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                            //                       ),
                            //                     ),
                            //                   //--------------if reached at branch & verified by BM-------------------
                            //                   if(1==2)
                            //                     Container(
                            //                       height: 75,
                            //                       width: 75,
                            //                       decoration: BoxDecoration(
                            //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                            //                           color: Colors.teal,
                            //                           borderRadius: BorderRadius.circular(50)
                            //                       ),
                            //                       child: Center(
                            //                         child: TextButton(onPressed: () {
                            //                           setState(() {
                            //
                            //                             // _initialColor = Colors.green;
                            //                             // _isVisible = !_isVisible;
                            //                           });
                            //                         },
                            //                           child: Text('CPTTR',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                            //                       ),
                            //                     ),
                            //                   //--------------if Trip end-------------------
                            //                   if(1==2)
                            //                     Container(
                            //                       height: 75,
                            //                       width: 75,
                            //                       decoration: BoxDecoration(
                            //                           border: Border.all(color: Colors.grey.shade300,width: 2),
                            //                           color: Colors.deepOrange,
                            //                           borderRadius: BorderRadius.circular(50)
                            //                       ),
                            //                       child: Center(
                            //                         child: TextButton(onPressed: () {
                            //                           setState(() {
                            //                             // _initialColor = Colors.green;
                            //                             // _isVisible = !_isVisible;
                            //                           });
                            //                         },
                            //                           child: Text('End',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),),),
                            //                       ),
                            //                     ),
                            //                   Container(
                            //                     width: 2,
                            //                     height: 50,
                            //                     color: Colors.black26,
                            //                     // color: index == totaldatacount.length-1 == 0 ? Colors.white : Colors.black26,
                            //                   ),
                            //
                            //                 ],
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(left: 15),
                            //                 child: Visibility(
                            //                   visible:true,
                            //                   child: Container(
                            //                     child: Column(
                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                            //                       children: [
                            //                         Text('10:32 AM',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black45),),
                            //                         Text('27-April-2022',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black54)),
                            //                         Text('Verified',style: GoogleFonts.poppins(fontSize: 13,color: Colors.green,fontWeight: FontWeight.w600)),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               )
                            //
                            //             ],
                            //           )
                            //       );
                            //     }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
