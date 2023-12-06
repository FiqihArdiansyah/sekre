class MHS {
  int? id;
  String? npm;
  String? nama;
  String? email;
  String? alamat;
  String? no_handpone;

  MHS(
      {this.id,
      this.npm,
      this.nama,
      this.email,
      this.alamat,
      this.no_handpone});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['npm'] = npm;
    map['nama'] = nama;
    map['email'] = email;
    map['alamat'] = alamat;
    map['no_handpone'] = no_handpone;

    return map;
  }

  MHS.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.npm = map['npm'];
    this.nama = map['nama'];
    this.email = map['email'];
    this.alamat = map['alamat'];
    this.no_handpone = map['no_handpone'];
  }
}
