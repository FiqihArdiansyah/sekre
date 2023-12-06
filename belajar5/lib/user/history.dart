import 'package:flutter/material.dart';
import 'homeUser.dart';
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  const History({Key? key, required this.nik, required this.NAMA})
      : super(key: key);
  final String nik;
  final String NAMA;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // int hargaAvanza = 100000;
  // int stokAvanza = 1;
  // int hargaInnova = 150000;
  // int stokInnova = 1;
  String teks = "Menunggu";
  String tolak = "Ditolak";
  List record = [];

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
        title: const Text('History'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: ListView.builder(
          itemCount: record.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
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
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                            margin:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                                child: Icon(
                                  Icons.people,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(7.0, 10, 0, 0),
                                child: Text(
                                  (record[index]["nama"]),
                                  style: const TextStyle(
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
                                child: Icon(
                                  Icons.card_membership,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(7.0, 5, 0, 0),
                                child: Text(
                                  (record[index]["nik"]),
                                  style: const TextStyle(
                                    color: Colors.lightBlue,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      //atas padd
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
                            NAMA: '${widget.NAMA}',
                          )),
                );
              },
              color: Colors.white,
            ),
            Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: IconButton(
                icon: const Icon(Icons.history),
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
