import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;


class MyHomePage1 extends StatefulWidget {
  final io.File imageFile;
  const MyHomePage1({Key? key,required this.imageFile}) : super(key: key);

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  io.File get imageFile => imageFile;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor: Colors.black,
      title: Text(''),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CropImage(
          controller: controller,
          image: Image.asset('assets/img/image.png')
        ),
      ),
    ),
    bottomNavigationBar: _buildButtons(),
  );

  Widget _buildButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [


      TextButton(
        onPressed: _finished,
        child: const Text('Done',style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    ],
  );



  Future<void> _finished() async {
    final image = await controller.croppedImage();
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(6.0),
          titlePadding: const EdgeInsets.all(8.0),
          title: const Text('Cropped image'),
          children: [

            const SizedBox(height: 5),
            image,
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}