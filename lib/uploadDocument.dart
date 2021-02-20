import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UploadDocument extends StatefulWidget {
  @override
  _UploadDocumentState createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  String fileType;
  String fileName;
  File file;
  String uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          //file = File(result.files.single.path);
          fileName = p.basename(file.path);
        });
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(
            type: FileType.custom, allowedExtensions: ['pdf']);
        setState(() {
          //file = File(result.files.single.path);
          fileName = p.basename(file.path);
        });
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.any);
        setState(() {
          //file = File(result.files.single.path);
          fileName = p.basename(file.path);
        });
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops!!!'),
              content: Text('Unable to upload file'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  Future<void> uploadFiles(File file, String filename) async {
    uid = _auth.currentUser.uid;
    firebase_storage.Reference storage;
    if (fileType == 'image') {
      storage = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$uid/$filename');
    }
    if (fileType == 'pdf') {
      storage = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$uid/$filename');
    }
    if (fileType == 'others') {
      storage = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$uid/$filename');
    }
    final firebase_storage.UploadTask uploadTask = storage.putFile(file);
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text("file uploaded successfully")));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Upload Documents'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return HomePage(user: _auth.currentUser);
                    }));
                },
              ),
            ),
            bottomNavigationBar: new BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4.0,
            ),
            floatingActionButton: new FloatingActionButton(
              child: Icon(Icons.cloud_upload),
              backgroundColor: Colors.blue,
              onPressed: () {
                uploadFiles(file, fileName);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple, Colors.lightBlue, Colors.purple],
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        'image',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      leading: Icon(Icons.image, color: Colors.white),
                      onTap: () {
                        setState(() {
                          fileType = 'image';
                        });
                        filePicker(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'PDF',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      leading: Icon(Icons.pages, color: Colors.white),
                      onTap: () {
                        setState(() {
                          fileType = 'pdf';
                        });
                        filePicker(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Others',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      leading: Icon(Icons.attach_file, color: Colors.white),
                      onTap: () {
                        setState(() {
                          fileType = 'others';
                        });
                        filePicker(context);
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
