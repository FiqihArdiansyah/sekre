import 'package:belajar5/controller/user_controller.dart';
import 'package:belajar5/login.dart';
import 'package:belajar5/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import '../main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  final _formKey = GlobalKey<FormState>();
  String _textFieldValue = '';
  TextEditingController nama = new TextEditingController();
  TextEditingController nik = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController uid = new TextEditingController();
  AddUser(userModel userModel) async {
    await UserContoller()
        .addUser(userModel)
        .then((Success) => {
              FlutterToastr.show("Akun berhasil di buat", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.bottom,
                  backgroundColor: Colors.green),
            })
        .onError((error, stackTrace) => {
              FlutterToastr.show("akun gagal di buat", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.center,
                  backgroundColor: Colors.red),
            });
  } // To store the text field value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
            child: Column(
              children: [
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    height: 150,
                    width: 150,
                    margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: DropShadow(
                      blurRadius: 4.5,
                      offset: const Offset(2, 2),
                      spread: 1,
                      child: Image.asset(
                        'assets/Logo_DriveR.png',
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: const DropShadow(
                      blurRadius: 2,
                      offset: Offset(0, 4),
                      spread: 0,
                      child: Text(
                        'DriveR',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: nama,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null; // Return null for no error
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: nik,
                      maxLength: 16,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: 'NIK',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter NIK';
                        }
                        return null; // Return null for no error
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null; // Return null for no error
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null; // Return null for no error
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            userModel UserModel = userModel(
                                nama: nama.text,
                                nik: nik.text,
                                email: email.text,
                                password: password.text);
                            AddUser(UserModel);
                            nama.clear();
                            nik.clear();
                            email.clear();
                            password.clear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }
                        },
                        icon: const Icon(Icons.app_registration),
                        label: const Text('Daftar'),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.lightBlue,
        child: Container(height: 50.0),
      ),
    );
  }
}
