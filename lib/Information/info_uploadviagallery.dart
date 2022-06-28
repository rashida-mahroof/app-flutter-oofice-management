import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class InfoUploadViaGallery extends StatefulWidget {
  const InfoUploadViaGallery({Key? key}) : super(key: key);

  @override
  State<InfoUploadViaGallery> createState() => _InfoUploadViaGalleryState();
}

class _InfoUploadViaGalleryState extends State<InfoUploadViaGallery> {
  late File?_imgfile=File('your initial file');
  ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Via Gallery'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: Column(children: [PreviewImg(),
            Text('YUYUY'),
            FloatingActionButton(
              onPressed: () {
                getImagebyGallery();
              },
              child: Icon(Icons.add),
            ),
          ]),
        )));
  }

  getImagebyGallery() async {
    PickedFile? pick = await _picker.getImage(source: ImageSource.gallery);
    if(pick!=null)
    {
      setState(() {
      _imgfile=File(pick.path);
    });
    }

  }

  Widget PreviewImg() {
    return Container(
      child: Image.asset(_imgfile!.path,fit: BoxFit.cover,),
    );
  }
}
