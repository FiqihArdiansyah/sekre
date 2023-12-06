import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDoperasi extends StatefulWidget {
  const CRUDoperasi({super.key});

  @override
  State<CRUDoperasi> createState() => _CRUDoperasiState();
}

class _CRUDoperasiState extends State<CRUDoperasi> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskController = TextEditingController();
  final CollectionReference _catatan =
      FirebaseFirestore.instance.collection('catatan');
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Center(
                //   child: Text(
                //     "Masukkan Catatan",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                TextField(
                  controller: _judulController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Judul",
                      hintText: 'Masukkan Judul'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _deskController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Deskripsi",
                      hintText: 'Masukkan Deskripsi'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String judul = _judulController.text;
                      final String deskripsi = _deskController.text;
                      if (judul != null) {
                        await _catatan
                            .add({"judul": judul, "deskripsi": deskripsi});
                        _judulController.text = '';
                        _deskController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Tambah Data"))
              ],
            ),
          );
        });
  }

  //update
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _judulController.text = documentSnapshot['judul'];
      _deskController.text = documentSnapshot['deskripsi'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Center(
                //   child: Text(
                //     "Masukkan Catatan",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                TextField(
                  controller: _judulController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Judul",
                      hintText: 'Masukkan Judul'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _deskController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Deskripsi",
                      hintText: 'Masukkan Deskripsi'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String judul = _judulController.text;
                      final String deskripsi = _deskController.text;
                      if (judul != null) {
                        await _catatan
                            .doc(documentSnapshot!.id)
                            .update({"judul": judul, "deskripsi": deskripsi});
                        _judulController.text = '';
                        _deskController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Ubah Data"))
              ],
            ),
          );
        });
  }

  //delete
  Future<void> _delete(String productID) async {
    await _catatan.doc(productID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Operasi"),
      ),
      body: StreamBuilder(
          stream: _catatan.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, Index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[Index];
                    return Card(
                      color: Color(0xFFECEAF4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          documentSnapshot['judul'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        subtitle: Text(
                          documentSnapshot['deskripsi'],
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(children: [
                            IconButton(
                                color: Colors.indigo,
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                color: Colors.redAccent,
                                onPressed: () {
                                  AlertDialog hapus = AlertDialog(
                                    title: Text("Informasi"),
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Text("Yakin ingin Menghapus Data")
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _delete(documentSnapshot.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ya")),
                                      TextButton(
                                        child: Text('Tidak'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                  showDialog(
                                      context: context,
                                      builder: (context) => hapus);
                                },
                                icon: const Icon(Icons.delete)),
                          ]),
                        ),
                      ),
                    );
                  });
            }
            return const Center();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
