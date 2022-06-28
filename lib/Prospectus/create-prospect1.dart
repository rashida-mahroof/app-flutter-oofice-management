import 'dart:convert';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Prospectus/prospect.dart';
import '../Login/home.dart';
import '../Model/users.dart';


final _formKey = GlobalKey<FormState>();
final _formKey1 = GlobalKey<FormState>();
class CreateProspect1 extends StatefulWidget {
  final List<Prospect> Obj;
  final List<String> product;
  final List<String> reason; 
  final List<String> price;
  final List<String> material;
  final List<String> size;

  const CreateProspect1({Key? key, required this.Obj, required this.product, required this.reason, required this.price, required this.material, required this.size}) : super(key: key);

  @override
  State<CreateProspect1> createState() => _CreateProspect1State();
}

class _CreateProspect1State extends State<CreateProspect1> {
  var radioButtonItem = 'Order';
  Object prodValue = 1;
  Object priceValue =1;
  Object sizeValue = 1;
  Object materialValue = 1;
  int id = 1;
  Object prsType = 'Followup';
  List<String> possiblity = [
   'HOT',
    'WARM',
    'COOL'
  ];
  int selectedIndex = 0;
  String financial='Budget';
  late List<ProspectProduct> addedProductList = [];
  late List<String> Reasonlist = widget.reason;
  late List<String> productList = widget.product;
  late List<String> PriceList = widget.price;
  late List<String> SizeList = widget.size;
  late List<String> materialList = widget.material;
  final reasonType = TextEditingController();
  final sizeController = TextEditingController();
  final prodController = TextEditingController();
  final materialController = TextEditingController();
  final PriceController = TextEditingController();
  final nxtstpController = TextEditingController();
  final sucessProductController = TextEditingController();
  final sucessCommentController = TextEditingController();
  final ReasonNoteController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Prospect'),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status : ',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                        CustomRadioButton(
                          elevation: 0,
                          absoluteZeroSpacing: false,
                          defaultSelected: 'Followup',
                          unSelectedColor: Theme.of(context).canvasColor,
                          unSelectedBorderColor:Colors.orange.shade800,
                          buttonLables: [
                            'Success',
                            'Followup'
                          ],
                          buttonValues: [
                            'Success',
                            'Followup'
                          ],
                          buttonTextStyle: ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: Colors.black54,
                              textStyle: TextStyle(fontSize: 13)),
                          radioButtonValue: (value) {
                            
                            setState((){
                              prsType = value!;
                            });
                          },

                          selectedColor: Colors.orange.shade800,
                          selectedBorderColor: Colors.grey.shade300,
                          padding: 5,
                          // enableShape: true,


                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    (prsType=='Success')?Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Radio(
                                   activeColor: Colors.deepOrange,
                                   value: 1,
                                   groupValue: id,
                                   onChanged: (val) {
                                     setState(() {
                                        radioButtonItem = 'Order';
                                       id = 1;
                                        
                                     });
                                   },
                                 ),
                                 Text(
                                     'Order',
                                     style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54)
                                 ),
                               ],
                             ),
                             Row(
                               children: [
                                 Radio(
                                   activeColor: Colors.deepOrange,
                                   value: 2,
                                   groupValue: id,
                                   onChanged: (val) {
                                     setState(() {
                                       radioButtonItem = 'Estimate';
                                       id = 2;
                                       
                                     });
                                   },
                                 ),
                                 Text(
                                     'Estimate',
                                     style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54)
                                 ),
                               ],
                             ),
                           ],
                         ),
                          Text('Products',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          TextFormField(
                            controller: sucessProductController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange.shade400),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 1),
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Products is required';
                              } else {
                                return null;
                              }
                            },
                          ),

                          if(radioButtonItem == 'Order')

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text('Delivery Date',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                              GestureDetector(
                                      onTap: () {
                                        _selectDeliveryDate(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.deepOrange,
                                            border: Border.all(
                                                color: Colors.orange
                                                    ),
                                            // borderRadius: BorderRadius
                                            //     .circular(6)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _selectDateRU(
                                                        context);
                                                  },
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.orange,
                                                    size: 30,
                                                  )),
                                              Text(
                                                "${selectedDated
                                                    .day}/${selectedDated
                                                    .month}/${selectedDated
                                                    .year}",
                                                style: GoogleFonts
                                                    .poppins(
                                                    color: Colors.grey
                                                        .shade700,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text('Comments',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          TextFormField(
                            controller: sucessCommentController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange.shade400),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 1),
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This feild is required';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ):Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Followup reason',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange)
                            ),
                            child: CustomDropdown(
                              hintText: 'Select Followup reason',
                              items: Reasonlist,
                              controller: reasonType,
                              excludeSelected: false,
                              fillColor: Colors.white,
                              
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Reason Note',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          TextFormField(
                            controller: ReasonNoteController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange.shade400),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 1),
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                          ),
                          SizedBox(height: 10,),
                          Text('Possiblity',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          Wrap(
                            spacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              spaceStatusRD(possiblity[0], 0),
                              spaceStatusRD(possiblity[1], 1),
                              spaceStatusRD(possiblity[2], 2),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text('Financial Status',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomRadioButton(
                                elevation: 0,
                                defaultSelected:'Budget',
                                absoluteZeroSpacing: false,
                                unSelectedColor: Theme.of(context).canvasColor,
                                unSelectedBorderColor:Colors.orange.shade800,
                                buttonLables: [
                                  'Premium',
                                  'Budget',
                                  'Economy'
                                ],
                                buttonValues: [
                                  'Premium',
                                  'Budget',
                                  'Economy'
                                ],
                                buttonTextStyle: ButtonTextStyle(
                                    selectedColor: Colors.white,
                                    unSelectedColor: Colors.black54,
                                    textStyle: TextStyle(fontSize: 13)),
                                radioButtonValue: (value) {
                               
                                  setState((){
                                      financial=value.toString();
                                  });
                                },

                                selectedColor: Colors.orange.shade800,
                                selectedBorderColor: Colors.grey.shade300,
                                padding: 5,
                                // enableShape: true,


                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Product',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius: BorderRadius.circular(
                                                      6)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: DropdownButton(

                                                      underline: Container(),
                                                      value: prodValue,
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                          color: Colors.black87),

                                                      onChanged: (value) {
                                                        setState(() {
                                                          prodValue = value!;
                                                        });
                                                      },

                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text('Select product',style: TextStyle(color: Colors.black45)),
                                                          value: 1,
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text('sofa'),
                                                          value: 2,
                                                        ),
                                                      ]


                                                  )

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],)),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Price',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius: BorderRadius.circular(
                                                      6)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: DropdownButton(

                                                      underline: Container(),
                                                      value: priceValue,
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                          color: Colors.black87),

                                                      onChanged: (value) {
                                                        setState(() {
                                                          priceValue = value!;
                                                        });
                                                      },

                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text('Select Price',style: TextStyle(color: Colors.black45)),
                                                          value: 1,
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text('12k - 20k'),
                                                          value: 2,
                                                        ),
                                                      ]


                                                  )

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('Size',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius: BorderRadius.circular(
                                                      6)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: DropdownButton(

                                                      underline: Container(),
                                                      value: sizeValue,
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                          color: Colors.black87),

                                                      onChanged: (value) {
                                                        setState(() {
                                                          sizeValue = value!;
                                                        });
                                                      },

                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text('Select Size',style: TextStyle(color: Colors.black45)),
                                                          value: 1,
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text('234'),
                                                          value: 2,
                                                        ),
                                                      ]


                                                  )

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],)),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('Material',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF),
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius: BorderRadius.circular(
                                                      6)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: DropdownButton(

                                                      underline: Container(),
                                                      value: materialValue,
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                          color: Colors.black87),

                                                      onChanged: (value) {
                                                        setState(() {
                                                          materialValue = value!;
                                                        });
                                                      },

                                                      items: [
                                                        DropdownMenuItem(
                                                          child: Text('Select Material',style: TextStyle(color: Colors.black45)),
                                                          value: 1,
                                                        ),
                                                        DropdownMenuItem(
                                                          child: Text('Mahagony'),
                                                          value: 2,
                                                        ),
                                                      ]


                                                  )

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],))
                            ],
                          ),
                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
                                final add=ProspectProduct(
                                  Product: prodController.text,
                                  Price:PriceController.text,
                                  Size: sizeController.text,
                                  Material: materialController.text
                                );
                                setState(() {
                                  addedProductList.add(add);
                                  prodController.clear();
                                  PriceController.clear();
                                  sizeController.clear();
                                  materialController.clear();
                                });
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePagetest()));
                              }, child: Row(
                                children: [
                                  Icon(Icons.add),
                                  Text('Add product'),
                                ],
                              )),
                            ],
                          ),
                          for(int i=0;i<addedProductList.length;i++)
                          ListTile(
                            trailing:IconButton(onPressed: () {
                              setState(() {
                                addedProductList.removeAt(i);
                              });
                              }, icon: Icon(Icons.close_outlined),),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(addedProductList[i].Product.toString(),style: GoogleFonts.poppins(fontSize: 13,),),
                                Text('Price:'+addedProductList[i].Price.toString(),style: GoogleFonts.poppins(fontSize: 13,))
                              ],
                            ),
                            subtitle: 
                              
                              
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Size:'+addedProductList[i].Size.toString(),style: GoogleFonts.poppins(fontSize: 12,)),
                                      ],
                                    ),
                                     Row(
                                  children: [
                                    Text('Material:'+addedProductList[i].Material.toString(),style: GoogleFonts.poppins(fontSize: 12,)),
                                  ],
                                )
                                  ],
                                ),
                               
                              
                            
                          ),
                          SizedBox(height: 10,),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next follow up date',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                    SizedBox(height: 3,),
                                    GestureDetector(
                                      onTap: () {
                                        _selectDateRU(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.deepOrange,
                                            border: Border.all(
                                                color: Colors.orange
                                                    ),
                                            // borderRadius: BorderRadius
                                            //     .circular(6)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _selectDateRU(
                                                        context);
                                                  },
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.orange,
                                                    size: 30,
                                                  )),
                                              Text(
                                                "${selectedDateRU
                                                    .day}/${selectedDateRU
                                                    .month}/${selectedDateRU
                                                    .year}",
                                                style: GoogleFonts
                                                    .poppins(
                                                    color: Colors.grey
                                                        .shade700,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next Step',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                                    SizedBox(height: 3,),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.orange)
                                      ),
                                      child: CustomDropdown(
                                        hintText: 'Select next step',
                                        items: ['Telecalling','Home visit','Mail','Quotation'],
                                        controller: nxtstpController,
                                        excludeSelected: false,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProspect()));
                          Navigator.pop(context);
                        }, child: Row(
                          children: [
                            Icon(Icons.keyboard_arrow_left),
                            Text('Previous',style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),),

                          ],
                        )),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      
                      widget.Obj[0].ProspectType=prsType.toString();
                      widget.Obj[0].SucessType=radioButtonItem;
                      widget.Obj[0].SucessProducts=sucessProductController.text;
                      widget.Obj[0].OrderDeliveryDate=selectedDated;
                      widget.Obj[0].SucessComments=sucessCommentController.text;
                      widget.Obj[0].ReasonType=reasonType.text;
                      widget.Obj[0].ReasonNote=ReasonNoteController.text;
                      widget.Obj[0].Possibility=possiblity[selectedIndex];
                      widget.Obj[0].FinancialStatus=financial;
                      widget.Obj[0].NextFollowUpdate=selectedDateRU;
                      widget.Obj[0].NextStep=nxtstpController.text;
                      var Posturi = Uri.parse(
          'https://www.hokybo.com/tms/api/Prospect/PostProspects');
      var request = http.MultipartRequest("POST", Posturi);
      request.fields['Source'] = widget.Obj[0].Source.toString();
      request.fields['SubSource'] = widget.Obj[0].SubSource.toString();
      request.fields['CustomerName'] = widget.Obj[0].CustomerName.toString();
      request.fields['Mobile'] = widget.Obj[0].Mobile.toString();
      request.fields['City'] = widget.Obj[0].City.toString();
      request.fields['Address'] = widget.Obj[0].Address.toString();
      request.fields['ProspectType'] = widget.Obj[0].ProspectType.toString();
      request.fields['SucessProducts'] = widget.Obj[0].SucessProducts.toString();
      request.fields['District'] = widget.Obj[0].District.toString(); 
      request.fields['OrderDeliveryDate'] = widget.Obj[0].OrderDeliveryDate.toString();
      request.fields['SucessComments'] = widget.Obj[0].SucessComments.toString();
      request.fields['ReasonType'] = widget.Obj[0].ReasonType.toString();
      request.fields['ReasonNote'] = widget.Obj[0].ReasonNote.toString();
      request.fields['Possibility'] = widget.Obj[0].Possibility.toString();
      request.fields['FinancialStatus'] = widget.Obj[0].FinancialStatus.toString();
      request.fields['NextFollowUpdate'] = widget.Obj[0].NextFollowUpdate.toString();
      request.fields['NextStep'] = widget.Obj[0].NextStep.toString();
      request.fields['UserID'] =globals.login_id.toString();
      request.fields['SucessType'] =widget.Obj[0].SucessType.toString();
      request.fields['Count'] =addedProductList.length.toString();
      for(int i=0;i<addedProductList.length;i++)
      {
        String pcode='ProductCode'+i.toString();
        String size='Size'+i.toString();
        String ma='Material'+i.toString();
        String pri='Price'+i.toString();
        request.fields[pcode] =addedProductList[i].Product.toString();
        request.fields[size] =addedProductList[i].Size.toString();
        request.fields[ma] =addedProductList[i].Material.toString();
        request.fields[pri] =addedProductList[i].Price.toString();
      }
      request.send().then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: 'Created Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white);

          // Navigator.pushReplacement(
          //     context,
          //     new MaterialPageRoute(
          //         builder: (BuildContext context) => InformationView()));
        }
        else
        {
           Fluttertoast.showToast(
              msg: 'Error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProspectsList()));
                    }
                    },
                        style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Create Prospect',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),)),
              ],
            ),
          )
        ],
      ),
    );
  }
  DateTime selectedDateRU = DateTime.now().add(Duration(days: 1));

  _selectDateRU(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDateRU,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.deepOrange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (selected != null && selected != selectedDateRU)
      setState(() {
        selectedDateRU = selected;
      });
  }
   DateTime selectedDated = DateTime.now().add(Duration(days: 1));

  _selectDeliveryDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDateRU,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.deepOrange,
                accentColor: const Color(0xFF8CE7F1),
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFFF7636)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
    if (selected != null && selected != selectedDateRU)
      setState(() {
        selectedDated = selected;
      });
  }
  void changeIndex1(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  Widget spaceStatusRD(String txt, int index) {
    return OutlinedButton(
        onPressed: () => changeIndex1(index),
        child: Text(
          txt,
          style: GoogleFonts.poppins(
              color: selectedIndex == index ? Colors.deepOrange : Colors.grey,
              fontWeight: selectedIndex == index ? FontWeight.w500 : FontWeight
                  .w400
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

    user = User.fromJson(json1);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => screenHome(Obj: json1)));
  }


  fetchProducts()async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetProducts'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];

        // UserList!.removeRange(1,UserList!.length);
        productList.clear();
        if (productList.length <= 1) {
          for (int i = 0; i < length; i++) {
            productList.add(jsn[i]['Product'].toString().toUpperCase());
          }
        }
        print(productList);

      }
  }

  fetchSize(String product)async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetSizes?Product='+product));
      final List<dynamic > jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        // UserList!.removeRange(1,UserList!.length);
    SizeList.clear();
        if (SizeList.length <= 1) {
          for (int i = 0; i < length; i++) {
            SizeList.add(jsn[i]['Size'].toString().toUpperCase());
          }
        }

      }
  }



 

}


