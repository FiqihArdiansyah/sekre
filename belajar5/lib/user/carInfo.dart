import 'package:flutter/material.dart';
import 'homeUser.dart';
import 'history.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({Key? key, required this.NIK, required this.NAMA})
      : super(key: key);
  final String NIK;
  final String NAMA;

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Information'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(0, 40.0, 0, 0),
        child: Column(
          children: [],
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
                  MaterialPageRoute(
                      builder: (context) => HomeUser(
                            NIK: '${widget.NIK}',
                            NAMA: '${widget.NAMA}',
                          )),
                );
              },
              color: Colors.white,
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
