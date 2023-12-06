import 'dart:convert';
import 'dart:async';
import 'package:belajar5/login.dart';
import 'package:belajar5/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'history.dart';
import 'carInfo.dart';
import 'package:http/http.dart' as http;
import 'package:belajar5/user/uploadKtp.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key, required this.NIK, required this.NAMA})
      : super(key: key);
  final String NIK;
  final String NAMA;

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  List record = [];

  Future<void> imageformdb() async {
    try {
      String uri = "http://192.168.50.163/carApi/viewm.php";
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
          title: const Text('DriveR'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[600],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ]),
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
                      GestureDetector(
                        onTap: () {
                          // Navigate to the second page when the image is tapped
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarInfo(
                                      NIK: '${widget.NIK}',
                                      NAMA: '${widget.NAMA}',
                                    )),
                          );
                        },
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          shadowColor: Colors.lightBlue,
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: 'http://192.168.50.163/carApi/' +
                                  record[index]["image_path"],
                              height: 150,
                              width: 220,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                            child: Text(
                              (record[index]["nama"]),
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Text(
                              'RP.' + record[index]["harga"],
                              style: const TextStyle(
                                color: Colors.lightBlue,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20.0, 5, 0, 0),
                            child: Text(
                              'Stok: ' + record[index]["stok"],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.normal,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 0.0, 0.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => uploadKtp(
                                              fotom: record[index]
                                                  ["image_path"],
                                              nik: '${widget.NIK}',
                                              nama: '${widget.NAMA}',
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text('Pesan'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Colors.green, // Set the text color
                                  elevation: 5, // Set the button's elevation
                                  // You can customize other button properties here
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
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
            Card(
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => History(
                            nik: '${widget.NIK}',
                            NAMA: '${widget.NAMA}',
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
