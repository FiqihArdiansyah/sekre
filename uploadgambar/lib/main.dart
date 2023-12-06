import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:uploadgambar/view_image.dart';

void main() => runApp(const MaterialApp(
      home: MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController caption = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;

  ImagePicker imagePicker = new ImagePicker();

  Future<void> uploadimage() async {
    try {
      String uri = "http://10.0.48.75/carApi/coba.php";
      // var caption;
      var res = await http.post(Uri.parse(uri), body: {
        "caption": caption.text,
        "data": imagedata,
        "name": imagename
      });
      var response = jsonDecode(res.body);
      if (response["succes"] == "true") {
        print("sedang upload");
      } else
        print("gagal");
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagepath = File(getimage!.path);
      imagename = getimage.path.split('/').last;
      imagedata = base64Encode(imagepath!.readAsBytesSync());
      print(imagepath);
      print(imagename);
      print(imagedata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("upload"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: caption,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("deskripsi")),
            ),
            SizedBox(
              height: 20,
            ),
            imagepath != null ? Image.file(imagepath!) : Text('image'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: Text('ambil')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    uploadimage();
                  });
                },
                child: Text('upload')),
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => view_image()));
                  },
                  child: Text("view"));
            })
          ],
        ),
      ),
    );
  }
}
