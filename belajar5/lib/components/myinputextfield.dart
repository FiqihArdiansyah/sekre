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
        ),
      ),
    );
  }
}
