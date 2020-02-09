import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VoterIDUpLoadPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<VoterIDUpLoadPage> {
  File imageFile;

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose Voter ID "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Open Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(12.0)),
                  GestureDetector(
                    child: Text("Open Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _imageView(),
            RaisedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Choose voter id'),
            )
          ],
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });

    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var camPicture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = camPicture;
    });

    Navigator.of(context).pop();
  }

  Widget _imageView() {
    if (imageFile == null) {
      return Text("No voter ID Selected");
    } else {
      return Image.file(imageFile, width: 400, height: 400);
    }
  }
}
