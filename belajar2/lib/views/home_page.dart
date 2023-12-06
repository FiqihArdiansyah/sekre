import 'package:belajar2/views/inventory_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventroy App',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(255, 72, 0, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return InventoryPage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InventoryPage();
                },
              ));
            },
            title: Text('Barang 1'),
            subtitle: Text('Deskripsi Barang 1'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InventoryPage();
                },
              ));
            },
            title: Text('Barang 1'),
            subtitle: Text('Deskripsi Barang 1'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InventoryPage();
                },
              ));
            },
            title: Text('Barang 1'),
            subtitle: Text('Deskripsi Barang 1'),
          ),
        ],
      ),
    );
  }
}
