import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screen/home/add/add_location.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/review.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/dialogbox.dart';
import 'package:flutter_app/shared/star_rating.dart';
import 'package:flutter_tags/tag.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {

  final Restaurant res;
  AddReview({ this.res });

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {

  String content;
  double rating = 5;

  final _formKey = GlobalKey<FormState>();
  // Image Captures
  File _image;
  File targetPath;
  // Image Storage
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://flutter-firebase-598d2.appspot.com');
  StorageUploadTask _uploadTask;
  String imageUrl = '';
  // Image Uploading
  bool isUploading = false;
  String uploadState = 'Upload';
  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
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
  void startUpload(File image) async {
    isUploading = true;
    String filePath = DateTime.now().toString().replaceAll(' ', '').replaceAll('-', '').replaceAll('.', '').replaceAll(':', '');
    String filePathFull = 'images/' + filePath;
    setState(() {
      _uploadTask = _storage.ref().child(filePathFull).putFile(_image);
    });
    if (_uploadTask.isInProgress) {
      setState(() {
        uploadState = 'Uploading...';
      });
    }
    await _uploadTask.onComplete;
    if (_uploadTask.isComplete){
      imageUrl = 'https://firebasestorage.googleapis.com/v0/b/flutter-firebase-598d2.appspot.com/o/images%2F' + filePath + '?alt=media';
      print('done fileid:' + filePath);
      setState(() {
        uploadState = 'Done';
      });
    }
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final color = Theme.of(context).accentColor;
    final size = 36.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Write a Review"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            children: <Widget>[
              Image.network('https://i.imgur.com/gTp3dlW.png', height: 50, width: 50,),
              SizedBox(height: 20.0),
              Text('Restaurant: \n${widget.res.name}', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20.0),
              Text(' Your Opinion: '),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5.0)
                  ),
                  color: Colors.white,
                ),
                height: 200,
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200.0,
                  ),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: SizedBox(
                        height: 190.0,
                        child: TextFormField(
                          maxLines: 100,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: 'content',
                          ),
                          validator: (val) => val.isEmpty ? 'Please enter your review.' : null,
                          onChanged: (val) => setState(() => content = val.trim()),
                          initialValue: '',
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(' Rating'),
              StarRating(
                rating: rating,
                onRatingChanged: (rating) => setState(() => this.rating = rating),
                size: 55,
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(' Image', textAlign: TextAlign.left,),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)
                      ),
                      color: Colors.white,
                    ),
                    child: _image == null
                        ? Center(child:Text('Upload an image.\n\n1. Select or Take Photo.\n2. Press Upload.', textAlign: TextAlign.center,),)
                        : Image.file(
                      _image,
                      height: 200,
                      width: 350,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 0,
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
                        label: Text(uploadState),
                        onPressed: () {
                          if (_image != null) {
                            if (isUploading) {
                              print('cannot upload because is uploading.');
                            } else
                              startUpload(_image);
                          }
                          if (_image == null) {
                            showAlertDialog(context,
                                "No Image Uploaded",
                                "Please upload a image.",
                                'OK',
                                "none");
                          }
                        },
                        heroTag: UniqueKey(),
                        backgroundColor: Colors.deepOrange,
                        icon: Icon(Icons.file_upload),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                  color: Colors.deepOrange,
                  child: Center(
                    child: Text(
                      'Upload Review',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (!isClicked) {
                      isClicked = true;
                      if(_formKey.currentState.validate()){
                        await ReviewService().newReview(widget.res.restaurant_id, user.uid, content, imageUrl, 0, 0, rating);
                        showAlertDialog(context,
                            "Thanks!",
                            "Your review on ${widget.res.name} have been published.",
                            'OK',
                            "none");
                      }
                      isClicked = false;
                    }
                  }
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.deepOrange[100],
    );
  }
}