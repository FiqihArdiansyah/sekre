import 'package:flutter/material.dart';
import 'Spesifik_Mobil.dart';

void _showSimpleDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Permintaan Terkirim",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}

class DetailMobil extends StatelessWidget {
  final title;
  final price;
  final color;
  final gearbox;
  final fuel;
  final brand;
  final path;

  DetailMobil(
      {this.title,
      this.price,
      this.color,
      this.gearbox,
      this.fuel,
      this.brand,
      this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("GoTrav"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            brand,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Hero(tag: title, child: Image.asset(path)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SpesifikMobil(
                name: '12 Month',
                price: price * 12,
                name2: 'Dollars',
              ),
              SpesifikMobil(
                name: '6 Month',
                price: price * 6,
                name2: 'Dollars',
              ),
              SpesifikMobil(
                name: '1 Month',
                price: price * 1,
                name2: 'Dollars',
              )
            ],
          ),
          SizedBox(height: 20),
          Text(
            'SPECIFICATIONS',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SpesifikMobil(
                name: 'Color',
                name2: color,
              ),
              SpesifikMobil(
                name: 'Gearbox',
                name2: gearbox,
              ),
              SpesifikMobil(
                name: 'Fuel',
                name2: fuel,
              )
            ],
          ),
          SizedBox(height: 10),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              _showSimpleDialog(context);
            },
            padding: EdgeInsets.all(10.0),
            color: Colors.blueAccent,
            child: Text(
              'Rental',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
