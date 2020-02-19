import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tags/tag.dart';

class AddRes extends StatefulWidget {

  @override
  _AddResState createState() => _AddResState();
}

class _AddResState extends State<AddRes> {
  final _formKey = GlobalKey<FormState>();

  String name;
  int phone;
  String imageUrl = 'https://i.imgur.com/gTp3dlW.png';

  // Image Captures
  File _image;
  File targetPath;
  // Image Storage
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://flutter-firebase-598d2.appspot.com');
  StorageUploadTask _uploadTask;
  // Image Uploading
  bool isUploading = false;
  String uploadState = 'Upload';

  // Tags
  List _items;


  final List _list = [
    'Chinese',
    'Japanese',
    'American',
    'Italian',
    'Maxican',
    'Indian',
    'French',
    'Thai',
    'Spanish',
    'Vietnamese',
    'Korean',
    'Taiwanese',
    'Middle Eastern',
    'British',
  ];

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List<String> _getAllItem(){
    List<String> returnList = [];
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if(lst!=null)
      lst.where((a) => a.active==true).forEach((a) => returnList.add(a.customData));
    return(returnList);
  }

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("New Restaurant"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            children: <Widget>[
              Image.network('https://i.imgur.com/gTp3dlW.png', height: 50, width: 50,),
              SizedBox(height: 20.0),
              Text(' Restaurant Name', textAlign: TextAlign.left,),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'restaurant name'),
                validator: (val) => val.isEmpty ? 'Please enter a name.' : null,
                onChanged: (val) => setState(() => name = val.trim()),
              ),
              SizedBox(height: 10.0),
              Text(' Phone Number', textAlign: TextAlign.left,),
              TextFormField(
                initialValue: '',
                decoration: textInputDecoration.copyWith(hintText: 'phone number'),
                validator: (val) => val.length < 8 ? 'Please enter a valid phone number.' : null,
                onChanged: (val) => setState(() => phone = int.parse(val.trim())),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(' Restaurant Avatar', textAlign: TextAlign.left,),
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
                      ? Center(child:Text('Upload a image.'),)
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
              ),
            SizedBox(height: 25),
            Text('Type of Food'),
              SizedBox(height: 5),
            Tags(
              key: _tagStateKey,
              alignment: WrapAlignment.start,
              columns: 4,
              itemCount: _items.length, // required
              itemBuilder: (int index){
                final item = _items[index];
                return ItemTags(
                  key: Key(index.toString()),
                  index: index,
                  active: false,
                  color: Colors.black12,
                  activeColor: Colors.deepOrange,
                  title: item,
                  customData: item,
                  textStyle: TextStyle(fontSize: 14),
                  combine: ItemTagsCombine.withTextBefore,
                  icon: ItemTagsIcon(
                    icon: Icons.add_circle,
                  ) ?? '',
                );
              },
            ),
            SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.deepOrange,
                  child: Center(
                    child: Text(
                      'Upload Restaurant',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    List<String> foodType = _getAllItem();
                    String stringFoodType = foodType.join(',');
                    if (stringFoodType == '') {
                      //TODO: notifi button
                      print('food type is empty');
                    } else
                    if (!_uploadTask.isComplete) {
                      //TODO: notifi
                      print('no image');
                    } else
                    if(_formKey.currentState.validate()){
                      await DatabaseService().newRes(name, stringFoodType, phone, new GeoPoint(0, 0), 0, 0, imageUrl);
                      Navigator.pop(context);
                      //TODO: alert successfully
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