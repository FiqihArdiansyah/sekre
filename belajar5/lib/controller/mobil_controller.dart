import 'dart:convert';
// import 'dart:html';

import 'package:belajar5/models/mobil_model.dart';
import 'package:http/http.dart' as http;

class MobilController {
  //in here i will create some methods like the following

  //let us create some constans
  // static const VIEW_URL = "http://10.0.48.75/carApi/viewm.php";
  static const CREATE_URL = "http://192.168.7.210/carApi/updatechek.php";
  // static const DELETE_URL = "http://192.168.87.105/students%20api/view.php";
  // static const UPDATE_URL = "http://192.168.87.105/students%20api/view.php";
  // static const VIEW_URL = "http://10.0.48.167/students%20api/view.php";
  // static const CREATE_URL = "http://10.0.48.167/students%20api/create.php";
  // static const DELETE_URL = "http://10.0.48.167/students%20api/delete.php";
  // static const UPDATE_URL = "http://10.0.48.167/students%20api/update.php";

  //lemme make looping, of map or as you know associative array
  List<mobilModel> studentsFromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    //let at maek app
    return List<mobilModel>.from(data.map((item) => mobilModel.fromJson(item)));
  }

  // Future<List<mobilModel>> getUser() async {
  //   // String view_ip = "http://10.0.48.167/students%20api/view.php";
  //   final response = await http.get(Uri.parse(VIEW_URL));
  //   if (response.statusCode == 200) {
  //     List<mobilModel> list = studentsFromJson(response.body);
  //     return list;
  //   } else {
  //     return <mobilModel>[];
  //   }
  // }

  //set data or add data
  // Future<String> addUser(mobilModel studentModel) async {
  //   final response =
  //       await http.post(Uri.parse(CREATE_URL), body: studentModel.toJsonAdd());
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return "Error";
  //   }
  // }

  //update data
  Future<String> UpdateStudent(mobilModel mobilModel) async {
    final response =
        await http.post(Uri.parse(CREATE_URL), body: mobilModel.toJsonUpdate());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error";
    }
  }

  //delete data
  // Future<String> DeleteStudent(studentModel studentModel) async {
  //   final response = await http.post(Uri.parse(DELETE_URL),
  //       body: studentModel.toJsonDelete_and_Update());
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return "Error";
  //   }
  // }
}
