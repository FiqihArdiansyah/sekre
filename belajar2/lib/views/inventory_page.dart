import 'package:belajar2/models/inventory.dart';
import 'package:belajar2/provider/firestore_service.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // var _nameContoller = TextEditingController();
  late TextEditingController nameContoller;
  late TextEditingController deskripsiContoller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameContoller = TextEditingController();
    deskripsiContoller = TextEditingController();
  }

  @override
  void dispose() {
    nameContoller.dispose();
    deskripsiContoller.dispose();
    //fungsi dispos untuk menghapus dari data" yang tadi
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory Page',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(255, 72, 0, 255),
        actions: [
          IconButton(
              onPressed: () {
                FirestoreService.addInventory(
                  Inventory(
                      name: nameContoller.text,
                      description: deskripsiContoller.text),
                );
              },
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameContoller,
              decoration: InputDecoration(
                  hintText: 'Masukkan Nama Barang Mu',
                  label: Text('Nama Barang')),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: deskripsiContoller,
              decoration: InputDecoration(
                  hintText: 'Masukkan Deskripsi barang Mu',
                  label: Text('Keterangan')),
            ),
          ],
        ),
      ),
    );
  }
}
