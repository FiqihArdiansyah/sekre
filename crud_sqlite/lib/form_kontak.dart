import 'package:flutter/material.dart';
import 'package:crud_sqlite/databases/db_helper.dart';
import 'package:crud_sqlite/models/mhs.dart';

class FormMHS extends StatefulWidget {
  final MHS? mhs;

  FormMHS({this.mhs});

  @override
  _FormMhsState createState() => _FormMhsState();
}

class _FormMhsState extends State<FormMHS> {
  DbHelper db = DbHelper();

  TextEditingController? npm;
  TextEditingController? nama;
  TextEditingController? email;
  TextEditingController? alamat;
  TextEditingController? no_handpone;

  @override
  void initState() {
    npm =
        TextEditingController(text: widget.mhs == null ? '' : widget.mhs!.npm);

    nama =
        TextEditingController(text: widget.mhs == null ? '' : widget.mhs!.nama);

    email = TextEditingController(
        text: widget.mhs == null ? '' : widget.mhs!.email);

    alamat = TextEditingController(
        text: widget.mhs == null ? '' : widget.mhs!.alamat);

    no_handpone = TextEditingController(
        text: widget.mhs == null ? '' : widget.mhs!.no_handpone);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: npm,
              decoration: InputDecoration(
                  labelText: 'NPM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: no_handpone,
              decoration: InputDecoration(
                  labelText: 'No Handpone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.mhs == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertMhs();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMhs() async {
    if (widget.mhs != null) {
      //update
      await db.updateMhs(MHS.fromMap({
        'id': widget.mhs!.id,
        'npm': npm!.text,
        'nama': nama!.text,
        'email': email!.text,
        'alamat': alamat!.text,
        'no_handpone': no_handpone!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMhs(MHS(
          npm: npm!.text,
          nama: nama!.text,
          email: email!.text,
          alamat: alamat!.text,
          no_handpone: no_handpone!.text));
      Navigator.pop(context, 'save');
    }
  }
}
