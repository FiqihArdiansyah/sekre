import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'homeAdmin.dart';
import 'checkout.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class addCar extends StatefulWidget {
  const addCar({super.key});

  @override
  State<addCar> createState() => _addCarState();
}

class _addCarState extends State<addCar> {
  final _formKey = GlobalKey<FormState>();
  String _textFieldValue = ''; // To store the text field value
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;
  ImagePicker imagePicker = new ImagePicker();

  Future<void> uploadimage() async {
    try {
      String uri = "http://192.168.50.163/carApi/upload.php";
      // var caption;
      var res = await http.post(Uri.parse(uri), body: {
        "nama": nama.text,
        "harga": harga.text,
        "stok": stok.text,
        "data": imagedata,
        "name": imagename
      });
      var response = jsonDecode(res.body);
      if (response["succes"] == "true") {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomeAdmin()),
        // );
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Car'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 2.0,
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                      child: imagepath != null
                          ? Image.file(imagepath!)
                          : ElevatedButton.icon(
                              onPressed: () {
                                getImage();
                              },
                              icon: const Icon(Icons.add_a_photo_outlined),
                              label: const Text('Upload Foto Mobil'),
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.lightBlue,
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  textStyle: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: nama,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter this field';
                        }
                        return null; // Return null for no error
                      },
                      onSaved: (value) {
                        _textFieldValue = value!;
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: harga,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter this field';
                        }
                        return null; // Return null for no error
                      },
                      onSaved: (value) {
                        _textFieldValue = value!;
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: stok,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Stok',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter this field';
                        }
                        return null; // Return null for no error
                      },
                      onSaved: (value) {
                        _textFieldValue = value!;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          uploadimage();
                        });
                        FlutterToastr.show("Mobil berhasil ditambah", context,
                            duration: FlutterToastr.lengthLong,
                            position: FlutterToastr.bottom,
                            backgroundColor: Colors.green);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeAdmin()),
                        );
                        // If the form is valid, save the form data and take action
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                      elevation: 5, // Button elevation
                      padding: const EdgeInsets.all(16.0), // Button padding
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.lightBlue,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeAdmin()),
                );
              },
              color: Colors.white,
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_checkout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Checkout()),
                );
              },
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
