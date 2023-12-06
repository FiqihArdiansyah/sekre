//i will create a class for model and how my data will be reading

class studentModel {
  final Name;
  final Email;
  final Address;
  final id;

  studentModel({this.Name, this.Email, this.Address, this.id});

  factory studentModel.fromJson(Map<String, dynamic> json) {
    return studentModel(
      Name: json['Name'],
      Email: json['Email'],
      Address: json['Address'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "Name": Name,
      "Email": Email,
      "Address": Address,
    };
  }

  Map<String, dynamic> toJsonDelete_and_Update() {
    return {
      "Name": Name,
      "Email": Email,
      "Address": Address,
      "id": id,
    };
  }
}
