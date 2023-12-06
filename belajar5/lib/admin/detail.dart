import 'package:belajar5/admin/checkout.dart';

import '/admin/homeAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class Detail extends StatefulWidget {
  final Map ListData;
  const Detail({Key? key, required this.ListData}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _form_key = GlobalKey<FormState>();
  // TextEditingController idt = new TextEditingController();
  String ket = "Terkonfirmasi";
  String tolak = "Ditolak";
  Future _update() async {
    return http.post(Uri.parse('http://192.168.50.163/carApi/konfirmasi.php'),
        body: {"idt": widget.ListData['idt'], "keterangan": ket});
  }

  Future _tolak() async {
    return http.post(Uri.parse('http://192.168.50.163/carApi/konfirmasi.php'),
        body: {"idt": widget.ListData['idt'], "keterangan": tolak});
  }

  void _confirm(context) async {
    await _update();
  }

  void _cancel(context) async {
    await _tolak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Detail'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40.0, 20, 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
              child: Card(
                elevation: 5.0,
                color: Colors.white,
                shadowColor: Colors.lightBlue,
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: 'http://192.168.50.163/carApi/' +
                        widget.ListData['fotomobil'],
                    height: 150,
                    width: 220,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5.0,
              color: Colors.white,
              shadowColor: Colors.lightBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                        child: const Icon(
                          Icons.people,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                        child: Text(
                          '${widget.ListData['nama']}',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                        child: const Icon(
                          Icons.card_membership,
                          color: Colors.black,
                          size: 26,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                        child: Text(
                          '${widget.ListData['nik']}',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 30.0),
                      child: Card(
                        elevation: 5.0,
                        color: Colors.white,
                        shadowColor: Colors.lightBlue,
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: 'http://192.168.50.163/carApi/' +
                                widget.ListData['fotoktp'],
                            height: 230,
                            width: 300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 0.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _confirm(context);
                              FlutterToastr.show(
                                  "Orderan Berhasil Di Konfirmasi", context,
                                  duration: FlutterToastr.lengthLong,
                                  position: FlutterToastr.bottom,
                                  backgroundColor: Colors.green);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Checkout()),
                              );
                            },
                            icon: const Icon(Icons.punch_clock),
                            label: const Text('Konfirmasi'),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.lightBlue, // Set the text color
                                elevation: 5,
                                textStyle: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ) // Set the button's elevation
                                // You can customize other button properties here
                                ),
                          )),
                      Container(
                          margin:
                              const EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 0.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _cancel(context);
                              FlutterToastr.show(
                                  "Orderan Telah Ditolak", context,
                                  duration: FlutterToastr.lengthLong,
                                  position: FlutterToastr.bottom,
                                  backgroundColor: Colors.red);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Checkout()),
                              );
                            },
                            icon: const Icon(Icons.punch_clock),
                            label: const Text('Tolak'),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.red, // Set the text color
                                elevation: 5,
                                textStyle: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ) // Set the button's elevation
                                // You can customize other button properties here
                                ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
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
