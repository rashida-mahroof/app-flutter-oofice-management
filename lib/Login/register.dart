import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Login/home.dart';
import 'package:untitled/Login/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../Model/users.dart';
import 'package:untitled/Login/globals.dart' as globals;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passhideshow = true;
  bool ckeboxValue = false;
  final _empcodeController = TextEditingController();
  final _erpPassController = TextEditingController();

  final _passwordController = TextEditingController();
  final _cnfrmpassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User user = User();
  bool _isDataMatched = true;
  bool isDataCrct = true;
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
              // SizedBox(
              //   height: 60,
              // ),
              Column(
                children: [
                  Container(
                      // height: 235,
                      alignment: Alignment.bottomCenter,
                      child:
                          //Image(image: AssetImage('assets/img/tiptop.png')),
                          Column(
                        children: [
                          Image.asset(
                            'assets/img/keybot.png',
                            width: 200,
                          )
                        ],
                      )),
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
                              controller: _empcodeController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10))),
                                hintText: 'Member Code',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(153, 129, 129, 129)),
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Color.fromARGB(153, 129, 129, 129),
                                ),
                                // filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _erpPassController,
                              autofocus: true,
                              obscureText: true,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10))),
                                hintText: 'ERP Password',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(153, 129, 129, 129)),
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
                                    'Invalid Member Code or ERP Password',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // TextFormField(
                            //   controller: _emailController,
                            //   decoration: const InputDecoration(
                            //     // border: OutlineInputBorder(
                            //     //     borderRadius:
                            //     //         BorderRadius.all(Radius.circular(10))),
                            //     hintText: 'Email Address',
                            //     hintStyle: TextStyle(
                            //         color: Color.fromARGB(153, 129, 129, 129)),
                            //     prefixIcon: Icon(
                            //       Icons.mail,
                            //       color: Color.fromARGB(153, 129, 129, 129),
                            //     ),
                            //     // filled: true,
                            //   ),
                            //   validator: (value) {
                            //     final bool isValid =
                            //         EmailValidator.validate(value!);
                            //     if (value == null || value.isEmpty) {
                            //       return 'Value is Empty';
                            //     } else if (isValid == false) {
                            //       return 'Invalid Email Address';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // TextFormField(
                            //   controller: _mobileController,
                            //   decoration: const InputDecoration(
                            //     // border: OutlineInputBorder(
                            //     //     borderRadius:
                            //     //         BorderRadius.all(Radius.circular(10))),
                            //     hintText: 'Mobile',
                            //     hintStyle: TextStyle(
                            //         color: Color.fromARGB(153, 129, 129, 129)),
                            //     prefixIcon: Icon(
                            //       Icons.phone_android,
                            //       color: Color.fromARGB(153, 129, 129, 129),
                            //     ),
                            //     // filled: true,
                            //   ),
                            //   validator: (value) {
                            //     const pattern =
                            //         r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                            //     final regExp = RegExp(pattern);
                            //     if (value == null || value.isEmpty) {
                            //       return 'Value is Empty';
                            //     } else if (!regExp.hasMatch(value) ||
                            //         value.length < 10 ||
                            //         value.length > 10) {
                            //       return 'Invalid Mobile Number';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: passhideshow,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10))),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(153, 129, 129, 129)),
                                prefixIcon: Icon(Icons.lock,
                                    color: Color.fromARGB(153, 129, 129, 129)),
                                // filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Value is Empty';
                                } else if (value.length < 5) {
                                  return 'Password must be 5 digits long';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _cnfrmpassController,
                              obscureText: passhideshow,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(10))),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(153, 129, 129, 129)),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(153, 129, 129, 129),
                                ),
                                // filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Value is Empty';
                                }
                                // else if(value != _passwordController){

                                //  return 'Password Mismatch';
                                // }
                                else {
                                  return null;
                                }
                              },
                            ),
                            CheckboxListTile(
                              title: Text(
                                "Show Password",
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              value: ckeboxValue,

                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  ckeboxValue = !ckeboxValue;
                                  passhideshow = !passhideshow;
                                });
                              }, //  <-- leading Checkbox
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_passwordController.text ==
                                            _cnfrmpassController.text) {
                                          var response2 = await http.post(
                                              Uri.parse(
                                                  'https://www.hokybo.com/tms/api/User/PostregisterUser?w=1'),
                                              headers: {
                                                "Content-Type":
                                                    "application/x-www-form-urlencoded",
                                              },
                                              encoding:
                                                  Encoding.getByName('utf-8'),
                                              body: ({
                                                'UserName':
                                                    _empcodeController.text,
                                                'ERPpwd':
                                                    _erpPassController.text,
                                                'Password':
                                                    _passwordController.text
                                              }));

                                          if (response2.statusCode == 200) {
                                            var json1 =
                                                jsonDecode(response2.body);
                                            user = User.fromJson(json1);

                                            if (user.userId == -2) {
                                              var id = user.userId;
                                              globals.login_id = id!;

                                              showDialog(
                                                  context: context,
                                                  builder: (ctx1) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text('Error'),
                                                      content: Text(
                                                          'User Already Exist'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(ctx1)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Close'))
                                                      ],
                                                    );
                                                  });
                                            } else if (user.userId == -1) {
                                              setState(() {
                                                isDataCrct = false;
                                              });
                                            } else {
                                              //print('success');
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        screenHome(Obj: json1)),
                                              );
                                              var id = user.userId;
                                              globals.login_id = id!;
                                              print(globals.login_id);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: 'Invalid Entries',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white);
                                          }
                                        } else {
                                          setState(() {
                                            _isDataMatched = false;
                                          });
                                        }

                                        // checkLogin(context);
                                      } else {}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.orange.shade700),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Register',
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
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ALready Registered?',
                                  style: TextStyle(color: Colors.grey),
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
                                          color: Color.fromARGB(
                                              255, 105, 185, 250)),
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
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> checkLogin(BuildContext ctx) async {
    final _empcode = _empcodeController.text;
    final erpPswd = _erpPassController.text;
    // final email = _emailController.text;
    // final mobile = _mobileController.text;
    final _password = _passwordController.text;
    final _cnfmpass = _cnfrmpassController.text;

    if (_password != _cnfmpass) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Password Mismatch')));
      var response2 = await http.post(
          Uri.parse('https://www.hokybo.com/tms/api/Approval/PostCreate'),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          encoding: Encoding.getByName('utf-8'),
          body: ({
            'UserName': _empcode,
            'ERPpwd': erpPswd,
            'Password': _password,
            // 'Email': email,
            // 'Mobile': mobile
          }));
      if (response2.statusCode == 200) {
        var json = jsonDecode(response2.body);
        user = User.fromJson(json);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screenHome(Obj: json)),
        );
      }
    }
  }
}
