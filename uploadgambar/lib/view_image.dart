import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_client/http_client.dart';

class view_image extends StatefulWidget {
  const view_image({super.key});

  @override
  State<view_image> createState() => _view_imageState();
}

class _view_imageState extends State<view_image> {
  List record = [];

  Future<void> imageformdb() async {
    try {
      String uri = "http://10.0.48.75/carApi/viewc.php";
      var response = await http.get(Uri.parse(uri));
      // var client = http.Client();
      // var response = await client.read(uri)
      // List data = JSON.decode(response);
      setState(() {
        record = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    imageformdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data")),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: record.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                    child: Expanded(
                        child: Image.network("http//10.0.48.75/carApi/" +
                            record[index]["image_path"]))),
                Container(
                  child: Text(record[index]["caption"]),
                )
              ]),
            );
          }),
    );
  }
}
