import 'package:agro/order/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class AddData extends StatefulWidget {
  final value;
  AddData({Key key, this.value}) : super(key: key);
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerquery = new TextEditingController();
  TextEditingController controllerimage = new TextEditingController();
  String username="";
  final String uploadEndPoint =
      'http://192.168.100.41/agro/images/upload_image.php';
  //for storing imported image
  Future<File> file;
  //for displaying status
  String status = '';
  //for converting string into base image
  String base64Image;
  // for storing original image temporarily
  File tmpFile;
  // error message
  String errMessage = 'Error Uploading Image';
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.contain,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  openCamera() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
  }

//to choose image from gallery
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
uploadToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
//to start upload and show server
  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return uploadToast('Image Not Uploaded');
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

// to post image to the folder on xampp
  upload(String fileName) {
    imageName = fileName;
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
  userDefine(){
      username= ScopedModel.of<CartModel>(context,
                              rebuildOnChange: true)
                          .useremail;
                    return username;
    }

  void addData() {
    var url = "http://192.168.100.41/agro/appApi/adddata.php";
    http.post(url, body: {
      "query": controllerquery.text,
      "image_url": '$imageName',
      "added_by": '${userDefine()}',
    });
    uploadToast('Query Posted');
Future.delayed(new Duration(milliseconds: 1000), ()
{
   Navigator.pop(context);
});
}

  String imageName;
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask Query"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Include Photo.',
                style: TextStyle(fontSize: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('Open Camera'),
                    onPressed: openCamera,
                  ),
                  OutlineButton(
                    onPressed: chooseImage,
                    child: Text('Choose Image'),
                  ),
                ],
              ),
              //for choosing image

              SizedBox(
                height: 20.0,
              ),
              //for showing image
              showImage(),

              SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: controllerquery,
                        maxLines: 10,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                            labelText: 'QueryField',
                            hintText: 'Enter your query here!',
                            labelStyle: TextStyle(
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 40.0,
                            width: 100,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {
                                  startUpload();
                                  addData();
                                },
                                child: Center(
                                  child: Text(
                                    'POST QUERY',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40.0,
                            width: 100,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.redAccent,
                              color: Colors.red,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
