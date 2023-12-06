import 'package:belajar5/admin/addCar.dart';
import 'package:belajar5/login.dart';
import 'package:flutter/material.dart';
import 'checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int hargaAvanza = 100000;

  int hargaInnova = 150000;
  int ss = 1;
  int stokInnova = 1;
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
          title: const Text('DriveR (Admin)'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[600],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('_conditionValue', 0);
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
            int strn = 1;
            // void _incrementCounter() {
            //   setState(() {
            //     // This call to setState tells the Flutter framework that something has
            //     // changed in this State, which causes it to rerun the build method below
            //     // so that the display can reflect the updated values. If we changed
            //     // _counter without calling setState(), then the build method would not be
            //     // called again, and so nothing would appear to happen.
            //     strn++;
            //   });
            // }

            int ins = int.parse(record[index]["stok"]);
            int n = ins + strn;
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
                                record[index]["image_path"],
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
                              'RP. ' + record[index]["harga"],
                              style: const TextStyle(
                                color: Colors.lightBlue,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20.0, 5, 0, 0),
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
                              // Container(
                              //   width: 40,
                              //   height: 40,
                              //   margin: const EdgeInsets.all(10.0),
                              //   child: Card(
                              //     elevation: 5.0,
                              //     child: IconButton(
                              //       icon: const Icon(Icons.remove),
                              //       onPressed: () {},
                              //       color: Colors.black,
                              //       iconSize: 17,
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: 40,
                              //   height: 40,
                              //   margin: const EdgeInsets.fromLTRB(
                              //       0, 10.0, 10.0, 10.0),
                              //   child: Card(
                              //     elevation: 5.0,
                              //     child: IconButton(
                              //       icon: const Icon(Icons.add),
                              //       onPressed:
                              //           // _incrementCounter
                              //           () {
                              //         int currentValue =
                              //             int.parse(record[index]["stok"]);
                              //         // if (n >= 1) {
                              //         setState(() {
                              //           currentValue++;
                              //           record[index]["stok"] =
                              //               (currentValue).toString();
                              //         });
                              //         // }
                              //       },
                              //       color: Colors.black,
                              //       iconSize: 17,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          // Container(
                          //   margin: const EdgeInsets.fromLTRB(20.0, 5, 0, 0),
                          //   child: ElevatedButton.icon(
                          //     onPressed: () {
                          //       // Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(builder: (context) => const LoginAdmin()),
                          //       // );
                          //     },
                          //     icon: const Icon(Icons.edit),
                          //     label: const Text('Edit'),
                          //     style: ElevatedButton.styleFrom(
                          //       textStyle: const TextStyle(
                          //           fontFamily: 'Outfit',
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 15.0),
                          //       elevation: 5, // Button elevation
                          //       padding:
                          //           const EdgeInsets.all(7.0), // Button padding
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Card(
                  //       margin: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                  //       elevation: 5.0,
                  //       color: Colors.white,
                  //       shadowColor: Colors.lightBlue,
                  //       child: Container(
                  //         child: const Image(
                  //           image: AssetImage(
                  //             'assets/innova.jpg',
                  //           ),
                  //           height: 150,
                  //           width: 220,
                  //         ),
                  //       ),
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           margin:
                  //               const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                  //           child: const Text(
                  //             'Innova',
                  //             style: TextStyle(
                  //               fontFamily: 'Outfit',
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 30.0,
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  //           child: Text(
                  //             'RP. $hargaInnova',
                  //             style: const TextStyle(
                  //               color: Colors.lightBlue,
                  //               fontFamily: 'Outfit',
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20.0,
                  //             ),
                  //           ),
                  //         ),
                  //         Row(
                  //           children: [
                  //             Container(
                  //               margin:
                  //                   const EdgeInsets.fromLTRB(20.0, 5, 0, 0),
                  //               child: Text(
                  //                 'Stok: $stokInnova',
                  //                 style: const TextStyle(
                  //                   color: Colors.grey,
                  //                   fontFamily: 'Outfit',
                  //                   fontWeight: FontWeight.normal,
                  //                   fontSize: 17.0,
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 40,
                  //               height: 40,
                  //               margin: const EdgeInsets.all(10.0),
                  //               child: Card(
                  //                 elevation: 5.0,
                  //                 child: IconButton(
                  //                   icon: const Icon(Icons.remove),
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       stokInnova -= 1;
                  //                     });
                  //                   },
                  //                   color: Colors.black,
                  //                   iconSize: 17,
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 40,
                  //               height: 40,
                  //               margin: const EdgeInsets.fromLTRB(
                  //                   0, 10.0, 10.0, 10.0),
                  //               child: Card(
                  //                 elevation: 5.0,
                  //                 child: IconButton(
                  //                   icon: const Icon(Icons.add),
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       stokInnova += 1;
                  //                     });
                  //                   },
                  //                   color: Colors.black,
                  //                   iconSize: 17,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Container(
                  //           margin: const EdgeInsets.fromLTRB(20.0, 5, 0, 0),
                  //           child: ElevatedButton.icon(
                  //             onPressed: () {},
                  //             icon: const Icon(Icons.edit),
                  //             label: const Text('Edit'),
                  //             style: ElevatedButton.styleFrom(
                  //               textStyle: const TextStyle(
                  //                   fontFamily: 'Outfit',
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 15.0),
                  //               elevation: 5, // Button elevation
                  //               padding:
                  //                   const EdgeInsets.all(7.0), // Button padding
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const addCar()),
          );
        },
        child: const Icon(Icons.add),
      ),
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
              icon: const Icon(Icons.shopping_cart_checkout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Checkout()),
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
