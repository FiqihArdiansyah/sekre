import 'dart:convert';

import 'package:belajar5/controller/mobil_controller.dart';
import 'package:belajar5/models/mobil_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homeUser.dart';
import 'history.dart';
import 'dart:io';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class uploadKtp extends StatefulWidget {
  const uploadKtp(
      {Key? key, required this.nama, required this.fotom, required this.nik})
      : super(key: key);
  // Step 2 <-- SEE HERE
  final String nik;
  final String nama;
  final String fotom;
  @override
  State<uploadKtp> createState() => _uploadKtpState();
}

class _uploadKtpState extends State<uploadKtp> {
  final _formKey = GlobalKey<FormState>();
  String _textFieldValue = '';
  TextEditingController total = TextEditingController();
  TextEditingController hari = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;
  ImagePicker imagePicker = new ImagePicker();

  Future<void> uploadimage() async {
    try {
      String uri = "http://192.168.50.163/carApi/uploadktp.php";
      // var caption;
      var res = await http.post(Uri.parse(uri), body: {
        "nama": widget.nama,
        "nik": widget.nik,
        "mobil": widget.fotom,
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
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);

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
        title: const Text('Validation'),
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
                              label: const Text('Upload Foto Ktp'),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                  child: Text(
                    'Pastikan Informasi KTP sesuai dengan Pendaftaran Akun',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                    ),
                  ),
                ),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //   child: Text(
                //     '${widget.nama}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 9, 0, 0),
                //       fontFamily: 'Outfit',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 19.0,
                //     ),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //   child: Text(
                //     'Rp. ${widget.nik}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 9, 0, 0),
                //       fontFamily: 'Outfit',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 19.0,
                //     ),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //   child: Text(
                //     'Stok ${widget.fotom}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 9, 0, 0),
                //       fontFamily: 'Outfit',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 19.0,
                //     ),
                //   ),
                // ),
                // Container(
                //   alignment: Alignment.bottomLeft,
                //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //   child: Text(
                //     'Stok ${widget.nik}',
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 9, 0, 0),
                //       fontFamily: 'Outfit',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 19.0,
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: FractionalOffset.topCenter,
                //   child: Container(
                //     width: 200,
                //     margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //     decoration: const BoxDecoration(
                //       color: Colors.white12,
                //     ),
                //     child: TextFormField(
                //       controller: hari,
                //       keyboardType: TextInputType.number,
                //       inputFormatters: <TextInputFormatter>[
                //         FilteringTextInputFormatter.digitsOnly
                //       ],
                //       decoration: const InputDecoration(
                //         labelText: 'Berapa Hari',
                //       ),
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Please enter this field';
                //         }
                //         return null; // Return null for no error
                //       },
                //       onSaved: (value) {
                //         _textFieldValue = value!;
                //         var hri = hari.text as int;
                //         var tt = widget.harga * hri;
                //       },
                //     ),
                //   ),
                // ),
                //  Container(
                //   alignment: Alignment.bottomLeft,
                //   margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //   child: Text(
                //     widget.tt,
                //     style: const TextStyle(
                //       color: Color.fromARGB(255, 9, 0, 0),
                //       fontFamily: 'Outfit',
                //       fontWeight: FontWeight.bold,
                //       fontSize: 19.0,
                //     ),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          uploadimage();
                        });
                        FlutterToastr.show("Mobil berhasil diorder", context,
                            duration: FlutterToastr.lengthLong,
                            position: FlutterToastr.bottom,
                            backgroundColor: Colors.green);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => History(
                                    nik: '${widget.nik}',
                                    NAMA: '${widget.nama}',
                                  )),
                        );
                        // If the form is valid, save the form data and take action
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Order'),
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
                  MaterialPageRoute(
                      builder: (context) => HomeUser(
                            NIK: '${widget.nik}',
                            NAMA: '${widget.nama}',
                          )),
                );
              },
              color: Colors.white,
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(
                            nik: '${widget.nik}',
                            NAMA: '${widget.nama}',
                          )),
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
