//i will create a class for model and how my data will be reading

class mobilModel {
  final keterangan;
  final idt;

  mobilModel({this.keterangan, this.idt});

  factory mobilModel.fromJson(Map<String, dynamic> json) {
    return mobilModel(
      keterangan: json['keterangan'],
      idt: json['idt'],
    );
  }

  // Map<String, dynamic> toJsonAdd() {
  //   return {
  //     "image_path": image_path,
  //     "nama": nama,
  //     "harga": harga,
  //     "stok": stok,
  //   };
  // }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "keterangan": keterangan,
      "idt": idt,
    };
  }
}
