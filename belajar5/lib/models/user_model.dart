//i will create a class for model and how my data will be reading

class userModel {
  final nama;
  final nik;
  final email;
  final password;
  final level;
  final uid;

  userModel(
      {this.nama, this.nik, this.email, this.password, this.level, this.uid});

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      nama: json['nama'],
      nik: json['nik'],
      email: json['email'],
      password: json['password'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "nama": nama,
      "nik": nik,
      "email": email,
      "password": password,
    };
  }

  // Map<String, dynamic> toJsonDelete_and_Update() {
  //   return {
  //     "Name": Name,
  //     "Email": Email,
  //     "Address": Address,
  //     "id": id,
  //   };
  // }
}
