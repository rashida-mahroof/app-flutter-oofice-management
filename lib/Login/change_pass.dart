import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Model/users.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool passhideshow = true;
  bool ckeboxValue = false;
  final _usernameController = TextEditingController();
  final _erpPswdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newpassController = TextEditingController();
  User user = User();
  bool _isDataMatched = true;
  bool isDataCrct = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
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
                      ],
                    )),

                //color: Colors.teal,
                Container(
                  width: (width > 900) ? width / 2 : width / .5,
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
                  child: Column(
                    children: [
                      Padding(
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
                                  //     borderRadius: BorderRadius.all(
                                  //         Radius.circular(10))),
                                  hintText: 'Member Code',
                                  focusColor: Colors.white,
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 161, 161, 161)),
                                  prefixIcon: Icon(
                                    Icons.account_box_rounded,
                                    color: Color.fromARGB(106, 143, 143, 143),
                                  ),
                                  // filled: true,
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
                                    return 'Value is Empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _erpPswdController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.all(
                                  //         Radius.circular(10))),
                                  hintText: 'ERP Password',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(153, 129, 129, 129)),
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Color.fromARGB(153, 129, 129, 129),
                                  ),
                                  // filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Value is Empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: !isDataCrct,
                                    child: Text(
                                      'Invalid Member code or ERP Password',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: passhideshow,
                                decoration: const InputDecoration(
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.all(
                                  //         Radius.circular(10))),
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(153, 129, 129, 129)),
                                  prefixIcon: Icon(Icons.lock,
                                      color:
                                          Color.fromARGB(153, 129, 129, 129)),
                                  // filled: true,
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
                                    return 'Value is Empty';
                                  } else if (value.length < 5) {
                                    return 'Password must be 5 digits';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _newpassController,
                                obscureText: passhideshow,
                                decoration: const InputDecoration(
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.all(
                                  //         Radius.circular(10))),
                                  hintText: 'Re-enter the Password',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(153, 129, 129, 129)),
                                  prefixIcon: Icon(Icons.lock,
                                      color:
                                          Color.fromARGB(153, 129, 129, 129)),
                                  // filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Value is Empty';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: !_isDataMatched,
                                    child: Text(
                                      'Password Mismatch',
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
                                value: ckeboxValue,

                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    ckeboxValue = !ckeboxValue;
                                    passhideshow = !passhideshow;
                                  });
                                }, //  <-- leading Checkbox
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          submitData();
                                        } else {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.orange.shade700),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Text(
                                            'Submit',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScreenLogin()));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenLogin()));
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 105, 185, 250)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitData() async {
    print('function');
    if (_passwordController.text == _newpassController.text) {
      var response2 = await http.post(
          Uri.parse(
              'https://www.hokybo.com/tms/api/User/PostChangePswd?a=1&b=2'),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: ({
            "UserName": _usernameController.text,
            "ERPpwd": _erpPswdController.text,
            "Password": _passwordController.text
          }));
      if (response2.statusCode == 200) {
        print(response2.body);
        var json1 = jsonDecode(response2.body);
        user = User.fromJson(json1);
        if (user.userId == -1) {
          setState(() {
            isDataCrct = false;
          });
        } else {
          showDialog(
              context: context,
              builder: (ctx1) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content:
                      Text('Password Changed.Login with Your New Password'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx1).pop();
                        },
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (ctx) {
                                return const ScreenLogin();
                              }));
                            },
                            child: const Text('Ok')))
                  ],
                );
              });
        }
      }
    } else {
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
