import 'dart:convert';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;
import 'package:untitled/Prospectus/prospect.dart';
import '../Login/home.dart';
import '../Model/users.dart';
import 'create-prospect1.dart';

final _formKey = GlobalKey<FormState>();

class CreateProspect extends StatefulWidget {
  const CreateProspect({Key? key}) : super(key: key);

  @override
  State<CreateProspect> createState() => _CreateProspectState();
}

class _CreateProspectState extends State<CreateProspect> {
  final _customerName = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  Object srcValue = 'Reference';
  Object SubsrcValue = 'Personal';
  late List<String>CityList=[];
   late List<String>DistrictList=[];
   late List<String>Reasonlist=[];
   late List<String>productList=[];
   late List<String>SizeList=[];
   late List<String>materialList=[];
   late List<String>PriceList=[];
   String _selectedDistrict="";
   String _selectedCity="";
   late List<Prospect> Obj=[];
  @override
  Widget build(BuildContext context) {
    fetchDistricts();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text('Source',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                    ),
                    CustomRadioButton(
                      defaultSelected: 'Reference',
                      elevation: 0,
                      absoluteZeroSpacing: false,
                      unSelectedColor: Theme.of(context).canvasColor,
                      unSelectedBorderColor:Colors.orange.shade800,
                      buttonLables: [
                        'Store',
                        'Reference'
                      ],
                      buttonValues: [
                        'Store',
                        'Reference'
                      ],
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black54,
                          textStyle: TextStyle(fontSize: 12)),
                      radioButtonValue: (value) {
                        print(value);
                        setState((){
                          srcValue = value!;
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text('Subsource  ',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                      (srcValue=='Store')?CustomRadioButton(
                        elevation: 0,
                        absoluteZeroSpacing: true,
                        defaultSelected: 'Walking',
                        unSelectedColor: Theme.of(context).canvasColor,
                        unSelectedBorderColor:Colors.orange.shade800,

                        buttonLables: [
                          'Walking',
                          'Field Marketing',
                          'Digital'
                        ],
                        buttonValues: [
                          'Walking',
                          'Field Marketing',
                          'Digital'
                        ],
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black54,
                            textStyle: TextStyle(fontSize: 12)),
                        radioButtonValue: (value) {
                          print(value);
                          setState((){
                            SubsrcValue=value!;
                          });
                        },
                        width: 130,
                        selectedColor: Colors.orange.shade800,
                        padding: 5,
                        selectedBorderColor: Colors.grey.shade300,
                        // enableShape: true,
                      ):CustomRadioButton(
                        elevation: 0,
                        absoluteZeroSpacing: true,

                        unSelectedColor: Theme.of(context).canvasColor,
                        unSelectedBorderColor:Colors.orange.shade800,
                        defaultSelected: 'Personal',
                        buttonLables: [
                          'Personal',
                          'Cust Reference'
                        ],
                        buttonValues: [
                          'Personal',
                          'Cust Reference'
                        ],
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black54,
                            textStyle: TextStyle(fontSize: 12)),
                        radioButtonValue: (value) {
                          print(value);
                          setState((){
                            SubsrcValue=value!;
                          });
                        },
                        width: 130,
                        selectedColor: Colors.orange.shade800,
                        padding: 5,
                        selectedBorderColor: Colors.grey.shade300,
                        // enableShape: true,
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Text('Customer Name',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                TextFormField(
                  controller: _customerName,
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
                      return 'Customer Name is required';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 1,
                ),
                SizedBox(height: 10,),
                Text('Mobile Number',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                TextFormField(
                  controller: _mobileController,
                    keyboardType: TextInputType.number,
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
                      return 'Mobile number is required';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 1,
                ),
                SizedBox(height: 10,),
                Text('District',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                DropdownSearch(
                  items: DistrictList,
                  onChanged: (value){
                    setState(() {
                      _selectedDistrict=value.toString();
                      fetchCity(value.toString());
                    });
                  },
                  showSearchBox: true,
                  selectedItem: "Select District",
                  validator: (String? item) {
                    if (item == null)
                      return "Required field";
                    else if (item == "Select District")
                      return "Please select District";
                    else
                      return null;
                  },
                ),
                SizedBox(height: 10,),
                Text('City',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                DropdownSearch(
                  items: CityList,
                  // dropdownSearchDecoration: InputDecoration(
                  //     labelText: "City",
                  //     border: OutlineInputBorder()
                  // ),
                  onChanged: (value){
                    setState(() {
                      _selectedCity=value.toString();
                    });
                  },
                  showSearchBox: true,
                  selectedItem: "Select City",
                  validator: (String? item) {
                    if (item == null)
                      return "Required field";
                    else if (item == "Select City")
                      return "Please select city";
                    else
                      return null;
                  },
                ),
                SizedBox(height: 10,),
                Text('Address',style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black54),),
                TextFormField(
                  controller: _addressController,
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
                      return 'Address is required';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 5,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: (){
    if (_formKey.currentState!.validate()) {
      final add=Prospect(
        Source: srcValue.toString(),
        SubSource: SubsrcValue.toString(),
        CustomerName: _customerName.text,
        Mobile:_mobileController.text,
        City: _selectedCity,
        District:_selectedDistrict,
        Address: _addressController.text
      );
      Obj.add(add);
      fetchProducts();
      fetchMaterial();
      fetchPrice();
      fetchReason();
      fetchSize('SOFA');
      if(Reasonlist.length>0 && productList.length>0 && materialList.length>0 && PriceList.length>0)
      {
              Navigator.push(context, MaterialPageRoute(
          builder: (context) => CreateProspect1(Obj: Obj,product: productList,material: materialList,price: PriceList,reason:Reasonlist,size: SizeList)));
      }
      


    }
                      },
                        style: ElevatedButton.styleFrom(primary: Colors.orange.shade800),
                        child: Row(
                      children: [
                        Text('Next Step',style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),),
                      Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    )),
                  ],
                )
              ],
            ),
          ),
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

   fetchDistricts()async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetDistricts'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        DistrictList.clear();
        if (DistrictList.length <= 1) {
          for (int i = 0; i < length; i++) {
            DistrictList.add(jsn[i]['District'].toString().toUpperCase());
          }
        }
      }
  }
  
  
  
  fetchCity(String district)async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetCities?District='+district));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];
        print(jsn);
        // UserList!.removeRange(1,UserList!.length);
        CityList.clear();
        if (CityList.length <= 1) {
          for (int i = 0; i < length; i++) {
            CityList.add(jsn[i]['City'].toString().toUpperCase());
          }
        }
      }
  }

  fetchReason()async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetReasonType'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];
     
        // UserList!.removeRange(1,UserList!.length);
        Reasonlist.clear();
        if (Reasonlist.length <= 1) {
          for (int i = 0; i < length; i++) {
            Reasonlist.add(jsn[i]['ResonType'].toString().toUpperCase());
          }
        }
      }
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


  fetchPrice()async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetPrices'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];
        
        // UserList!.removeRange(1,UserList!.length);
          PriceList.clear();
          if(PriceList.length<=1)
          {
            for (int i = 0; i < length; i++) {
            PriceList.add(jsn[i]['Prices'].toString().toUpperCase());
          }
          }
          

      }
  }

  fetchMaterial()async
  {
    final response = await http.get(Uri.parse('https://www.hokybo.com/tms/api/Prospect/GetMaterials'));
      final List<dynamic> jsn;
      if (response.statusCode == 200) {
        jsn = jsonDecode(response.body);
        int length = jsn.length;
        //UserList=[];
        // UserList!.removeRange(1,UserList!.length);
          materialList.clear();
          if(materialList.length<=1)
          {
            for (int i = 0; i < length; i++) {
            materialList.add(jsn[i]['Materials'].toString().toUpperCase());
          }
          }
          

      }
  }



}