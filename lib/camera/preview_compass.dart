import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// packages screenshot
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_icons/flutter_icons.dart';

// Compass



class PreviewCompass extends StatefulWidget{
  final String imgPath;
  final String compassPath;
  final String roomName;

  const PreviewCompass({Key key, this.imgPath, this.compassPath, this.roomName}) : super(key: key);

  //PreviewCompass({this.imgPath,this.roomName});


  @override
  _PreviewCompassState createState() => _PreviewCompassState();

}
class _PreviewCompassState extends State<PreviewCompass>{

  // Screenshot

  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();





  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child:
      Scaffold(
        backgroundColor: Colors.blue.shade900,

        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("ORIENTATION PIECE"),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Expanded(
            flex: 2,
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[

        new Positioned.fill(child:
        Image.file(File(widget.imgPath),fit: BoxFit.fill,),),

            new Positioned.fill(child:
            Image.file(File(widget.compassPath),fit: BoxFit.fill,),),
              /*
              Expanded(
               // flex: 1,
                child:
                Image.file(File(widget.imgPath),fit: BoxFit.fill,),
              ),

              Align(
               // alignment: Alignment.bottomCenter,
                child:  Image.file(File(widget.compassPath),fit: BoxFit.fill,),
              ),*/
],
          ),
            ),
              Card(
                  margin: EdgeInsets.symmetric( horizontal: 10.0, vertical :5.0),
                  child: ListTile (
                    leading: Icon(
                      FontAwesome.compass,
                      color: Colors.blue.shade900,
                    ),
                    title: (
                        Text (widget?.roomName,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Source Sans Pro',
                              color: Colors.blue.shade900,
                            )
                        )
                    ),
                  )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  color: Colors.black,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.share,color: Colors.white,),
                      onPressed: () async {
                        _takeScreenshotandShare();
                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  // Screenshot

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Screenshot', 'screenshot.png', pngBytes, 'image/png');
    })
        .catchError((onError) {
      print(onError);
    });
  }



}

