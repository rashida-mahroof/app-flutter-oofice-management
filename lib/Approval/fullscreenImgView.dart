import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class FullScreenImage extends StatefulWidget {
  const FullScreenImage({required this.imageUrl});
  final String imageUrl;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  Icon dwldIcon = Icon(Icons.download,size: 30,);
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;
  DateTime today = DateTime.now();
  String newPath = "";
  Future<bool> saveFileGallery(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = (await getExternalStorageDirectory())!;

          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/KeyBot";
          directory = Directory(newPath);

        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    int i = 2022001;
    Random random = Random();
    int _randomNumber1 = random.nextInt(100000);
    print(_randomNumber1);
    String fileName = widget.imageUrl.split('/').last;
    bool downloaded = await saveFileGallery(
        widget.imageUrl, 'KB' + _randomNumber1.toString() + fileName);
    if (downloaded) {
      print("File Downloaded");
      setState((){
        dwldIcon = Icon(Icons.download_done_rounded);
      });
      Fluttertoast.showToast(
          msg: 'File Downloaded',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white);
      i = i++;
      String? loadMediaMessage;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        loadMediaMessage = await MediaScanner.loadMedia(path: newPath);
      } on PlatformException {
        loadMediaMessage = 'Failed to get platform version.';
        print(loadMediaMessage);
      }
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        actions: [
          loading
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    value: progress,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.orange.shade800),
                  ),
                )
              : IconButton(
                  onPressed: downloadFile,
                  // () {
                  //   downloadFile;
                  //   // print(widget.imageUrl);
                  // },
                  icon: dwldIcon)
        ],
      ),
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: PinchZoom(
          child: Hero(
            tag: 'h',
            child: Center(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                alignment: Alignment.center,
              ),
            ),
          ),
          resetDuration: const Duration(milliseconds: 100),
          maxScale: 4,
          onZoomStart: () {
            print('Start zooming');
          },
          onZoomEnd: () {
            print('Stop zooming');
          },
        ),
        onDoubleTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
