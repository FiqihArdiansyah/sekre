import 'package:flutter/material.dart';
import 'package:crud_sqlite/databases/db_helper.dart';
import 'form_kontak.dart';
import 'list_mhs.dart';
import 'package:crud_sqlite/models/mhs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ListMhsPage(),
    );
  }
}
