import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Login/change_pass.dart';
import 'package:untitled/Login/home.dart';
import 'package:untitled/Login/register.dart';
import 'package:untitled/Model/users.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Login/globals.dart' as globals;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

Future<User?> submitData(String username, String pwd) async {}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();
  bool _passhideshow = true;
  final _passwordController = TextEditingController();
  bool ckeboxvalue = false;
  final _formKey = GlobalKey<FormState>();
  User user = User();
  bool _isDataMatched = true;
  int isActive = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        // backgroundColor:Colors.orange[50],
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 120,
              // ),
              Container(
                  // height: 235,
                  alignment: Alignment.bottomCenter,
                  child:
                      //Image(image: AssetImage('assets/img/tiptop.png')),
                      Column(
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/img/keybot.png',
                        width: 200,
                      )),
                      // Text(
                      //   'KeyBot',
                      //   style: GoogleFonts.poppins(
                      //       color: Colors.orange.shade900,
                      //       fontSize: 40,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Text(
                      //   'Biz Manager',
                      //   style: GoogleFonts.poppins(
                      //     color: Colors.black87,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ],
                  )),
              //Text('Login with Your Employee Code and Registered Password'),
              Container(
                width: (width > 900) ? width / 2 : width / .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFffff).withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ]),
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 40, bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //crossAxisAlignment:  CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            hintText: 'Member ID',
                            focusColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 161, 161, 161)),
                            prefixIcon: Icon(
                              Icons.account_box,
                              color: Color.fromARGB(106, 143, 143, 143),
                            ),
                            // filled: true,
                            // fillColor: Color.fromARGB(255, 255, 251, 250),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _passhideshow,
                          decoration: const InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 161, 161, 161)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(106, 143, 143, 143),
                            ),

                            // filled: true,
                            // fillColor: Color.fromARGB(255, 255, 251, 250),
                          ),
                          validator: (value) {
                            // if (_isDataMatched)
                            // {
                            //   return null;
                            // }
                            // else{
                            //   return 'error';
                            // }
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: !_isDataMatched,
                              child: Text(
                                'Invalid Username or Password',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        CheckboxListTile(
                          title: Text(
                            "Show Password",
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                          value: ckeboxvalue,

                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? value) {
                            setState(() {
                              ckeboxvalue = !ckeboxvalue;
                              _passhideshow = !_passhideshow;
                            });
                          }, //  <-- leading Checkbox
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePassword()));
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 105, 185, 250)),
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  String username = _usernameController.text;
                                  String pwd = _passwordController.text;
                                  if (_formKey.currentState!.validate()) {
                                    var response2 = await http.post(
                                        Uri.parse(
                                            'https://www.hokybo.com/tms/api/User/Post'),
                                        headers: {
                                          "Content-Type":
                                              "application/x-www-form-urlencoded",
                                        },
                                        encoding: Encoding.getByName('utf-8'),
                                        body: ({
                                          'UserName': username,
                                          'Password': pwd
                                        }));

                                    if (response2.statusCode == 200) {
                                      var json = jsonDecode(response2.body);
                                      user = User.fromJson(json);
                                      var id = user.userId;
                                      isActive = user.isActive!;

                                      globals.login_id = id!;
                                      globals.BranchID=user.branchId!;
                                      globals.RoleId=user.roleId!;

                                      final _sharedPrefs =
                                          await SharedPreferences.getInstance();
                                      await _sharedPrefs.setInt(
                                          'PREF_ID', globals.login_id);

                                      var name = user.name;
                                      var role = user.role;

                                      if (id > 0 && isActive > 0) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    screenHome(Obj: json)));
                                      } else {
                                        setState(() {
                                          _isDataMatched = false;
                                        });
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange.shade700),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not have an account?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 105, 185, 250)),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;
    if (_username == _password) {
      //goto home

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
          content: Text('Login Success')));
      // String name = _usernameController.text;
      //       String job = _passwordController.text;

      //       DataModel? data = await submitData(name, job);

    } else {
      //snackbar
      // ignore: prefer_const_declarations
      final _errormsg = _username + ' and ' + _password + ' does not match';
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          content: Text(_errormsg)));

      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
