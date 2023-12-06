import 'package:belajar5/admin/detail.dart';
import 'package:belajar5/admin/homeAdmin.dart';
import 'package:belajar5/controller/mobil_controller.dart';
import 'package:belajar5/models/mobil_model.dart';
import 'package:belajar5/user/history.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _form_key = GlobalKey<FormState>();
  List record = [];
  String teks = "Menunggu";
  String tolak = "Ditolak";

  Future<void> imageformdb() async {
    try {
      String uri = "http://192.168.50.163/carApi/viewt.php";
      var response = await http.get(Uri.parse(uri));
      setState(() {
        record = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> ubaah() async {
    try {
      String uri = "http://192.168.50.163/carApi/updatechek.php";
      var response = await http.post(Uri.parse(uri));
      setState(() {
        record = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      imageformdb();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: ListView.builder(
          itemCount: record.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(
                              ListData: {
                                "idt": record[index]["idt"],
                                "fotomobil": record[index]["mobil"],
                                "nama": record[index]["nama"],
                                "nik": record[index]["nik"],
                                "fotoktp": record[index]["image_ktp"],
                              },
                            )),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 5.0,
                          color: Colors.white,
                          shadowColor: Colors.lightBlue,
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: 'http://192.168.50.163/carApi/' +
                                  record[index]["mobil"],
                              height: 150,
                              width: 220,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                                  child: const Icon(
                                    Icons.people,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(7.0, 10, 0, 0),
                                  child: Text(
                                    (record[index]["nama"]),
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                                  child: const Icon(
                                    Icons.card_membership,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(7.0, 5, 0, 0),
                                  child: Text(
                                    (record[index]["nik"]),
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: const Text(
                                'Status',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Text(
                                (record[index]["keterangan"]),
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                  color: tolak == (record[index]["keterangan"])
                                      ? Colors.red
                                      : teks == (record[index]["keterangan"])
                                          ? Colors.yellow
                                          : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
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
            Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_checkout),
                onPressed: () {},
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
