import 'package:crud_sqlite/models/mhs.dart';
import 'package:flutter/material.dart';
import 'form_kontak.dart';

import 'package:crud_sqlite/databases/db_helper.dart';

class ListMhsPage extends StatefulWidget {
  const ListMhsPage({Key? key}) : super(key: key);

  @override
  _ListMhsPageState createState() => _ListMhsPageState();
}

class _ListMhsPageState extends State<ListMhsPage> {
  List<MHS> listMhs = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllMhs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Mahasiswa App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listMhs.length,
          itemBuilder: (context, index) {
            MHS mhs = listMhs[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${mhs.npm}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nama: ${mhs.nama}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${mhs.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Alamat: ${mhs.alamat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Telpon: ${mhs.no_handpone}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(mhs);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Informasi"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Yakin ingin Menghapus Data ${mhs.nama}")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteKontak() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteMhs(mhs, index);
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
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllMhs() async {
    //list menampung data dari database
    var list = await db.getAllMhs();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listMhs.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((mhs) {
        //masukan data ke listKontak
        listMhs.add(MHS.fromMap(mhs));
      });
    });
  }

  //menghapus data Kontak
  Future<void> _deleteMhs(MHS mhs, int position) async {
    await db.deleteMhs(mhs.id!);
    setState(() {
      listMhs.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMHS()));
    if (result == 'save') {
      await _getAllMhs();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(MHS mhs) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMHS(mhs: mhs)));
    if (result == 'update') {
      await _getAllMhs();
    }
  }
}
