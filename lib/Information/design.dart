import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Color.fromARGB(255, 49, 49, 49),
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {},
                                      tooltip: "Pick Image form Camera",
                                      child: const Icon(Icons.add_a_photo),
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {},
                                      tooltip: "Pick Image form Gallery",
                                      child: const Icon(Icons.camera),
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  // setState(() {

                  //   isHidden = !isHidden;

                  // });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  'Add Image',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Image.asset(
                'assets/img/user.jpg',
                fit: BoxFit.fill,
              ),
            ),
            GFButton(onPressed: () {}, blockButton: true, child: Text('SEND'))
          ],
        ),
      ),
    );
  }
}
