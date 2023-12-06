import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  MyTextFields(
      {super.key,
      required this.hintedtext,
      required this.lableltext,
      required this.Inputcontroller});

  final String hintedtext;
  final String lableltext;
  final TextEditingController Inputcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: Inputcontroller,
        validator: (value) {
          if (value!.isEmpty) {
            return "$lableltext is required";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintedtext,
          labelText: lableltext,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blueAccent)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.red)),
        ),
      ),
    );
  }
}
