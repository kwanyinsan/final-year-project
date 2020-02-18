import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();

  final String id;
  ImageCapture({this.id});

}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  static File _image;
  File targetPath;

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://flutter-firebase-598d2.appspot.com');

  StorageUploadTask _uploadTask;

  getImageFile(ImageSource source) async {

    //Clicking or Picking from Gallery

    var image = await ImagePicker.pickImage(source: source);

    //Cropping the image
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
      compressQuality: 80,
    );

    setState(() {
      _image = croppedFile;
      print(_image.lengthSync());
    });
  }

  void startUpload(File image) {
    String marker = widget.id;
    String filePath = 'images/'+marker+'/${DateTime.now()}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_image);
    });

    if (_uploadTask.isSuccessful){
      print('done' + filePath);
    }
  }

  String uploadState() {
    if (_image != null) {
      if (_uploadTask.isInProgress) {
        return 'Uploading';
      }
      if (_uploadTask.isSuccessful) {
        return 'Done';
      }
    }
    return 'Upload';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.deepOrange,
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)
            ),
            color: Colors.transparent,
          ),
          child: _image == null
              ? Center(child:Text('Upload a image.'),)
              : Image.file(
            _image,
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(

          children: <Widget>[
            SizedBox(
              width: 75,
            ),
            FloatingActionButton.extended(
              label: Icon(Icons.camera_alt),
              onPressed: () => getImageFile(ImageSource.camera),
              heroTag: UniqueKey(),
              backgroundColor: Colors.deepOrange,
            ),
            SizedBox(
              width: 5,
            ),
            FloatingActionButton.extended(
              label: Icon(Icons.photo_library),
              onPressed: () => getImageFile(ImageSource.gallery),
              heroTag: UniqueKey(),
              backgroundColor: Colors.deepOrange,
            ),
            SizedBox(
              width: 5,
            ),
            FloatingActionButton.extended(
              label: Text(uploadState()),
              onPressed: () {
                if (_image != null) {
                  if (_uploadTask.isInProgress || _uploadTask.isSuccessful) {
                    print('cannot upload because is uploading.');
                  }
                  startUpload(_image);
                }
                if (_image == null) {
                  //TODO: notifi need image
                  print('no image found!');
                }
              },
              heroTag: UniqueKey(),
              backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.file_upload),
            ),
          ],
        )
      ],
    );
  }
}