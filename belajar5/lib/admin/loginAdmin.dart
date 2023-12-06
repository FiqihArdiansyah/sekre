import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'homeAdmin.dart';


class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final _formKey = GlobalKey<FormState>();
  String _textFieldValue = ''; // To store the text field value

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
                    margin: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
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
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: TextFormField(
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
                      onSaved: (value) {
                        _textFieldValue = value!;
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
                            // If the form is valid, save the form data and take action
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeAdmin()
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                          ),
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




