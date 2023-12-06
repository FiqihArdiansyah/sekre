import 'package:belajar4/components/myinputextfield.dart';
import 'package:belajar4/controllers/student_controller.dart';
import 'package:belajar4/models/student_model.dart';
import 'package:belajar4/screens/students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
//lemme enable in here to edit and add new students

class Add_Edit_Student extends StatefulWidget {
  final studentModel? studentmodel;
  final index;

  const Add_Edit_Student({this.studentmodel, this.index});

  @override
  State<Add_Edit_Student> createState() => _Add_Edit_StudentState();
}

class _Add_Edit_StudentState extends State<Add_Edit_Student> {
  bool isEdited_mode = false;
  final _form_key = GlobalKey<FormState>();
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController id = TextEditingController();

  AddStudent(studentModel studentModel) async {
    await StudentContoller().addStudent(studentModel).then((Success) => {
          FlutterToastr.show("Students Is created Succesfully", context,
              duration: FlutterToastr.lengthLong,
              position: FlutterToastr.center,
              backgroundColor: Colors.green),
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => StudentsPage()))),
        });
  }

  UpdateStudent(studentModel studentmodel) async {
    await StudentContoller()
        .UpdateStudent(studentmodel)
        .then((Success) => {
              FlutterToastr.show("Students Is Update Succesfully", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.center,
                  backgroundColor: Colors.green),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => StudentsPage()))),
            })
        .onError((error, stackTrace) => {
              FlutterToastr.show("Student is not Update", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.center,
                  backgroundColor: Colors.red),
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.index != null) {
      isEdited_mode = true;
      Name.text = widget.studentmodel?.Name;
      Email.text = widget.studentmodel?.Email;
      Address.text = widget.studentmodel?.Address;
      id.text = widget.studentmodel?.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdited_mode ? "Update Student" : "Add Student"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          //some text
          Center(
            child: Text(
              "Submit registration Form",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          SizedBox(height: 30.0),
          // from and its text fields
          Form(
              key: _form_key,
              child: Column(
                children: [
                  MyTextFields(
                      hintedtext: "Ful Name here",
                      lableltext: "Name",
                      Inputcontroller: Name),
                  SizedBox(height: 10.0),
                  MyTextFields(
                      hintedtext: "example@gmail.com",
                      lableltext: "Email",
                      Inputcontroller: Email),
                  SizedBox(height: 10.0),
                  MyTextFields(
                      hintedtext: "Halane borama somaliland",
                      lableltext: "Address",
                      Inputcontroller: Address),
                ],
              )),
          SizedBox(height: 10.0),
          //submit button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(300.0, 60), elevation: 20.0),
              onPressed: () {
                if (isEdited_mode == true) {
                  if (_form_key.currentState!.validate()) {
                    studentModel studenModel = studentModel(
                        id: id.text,
                        Name: Name.text,
                        Email: Email.text,
                        Address: Address.text);
                    UpdateStudent(studenModel);
                    Name.clear();
                    Email.clear();
                    Address.clear();
                  }
                } else {
                  if (_form_key.currentState!.validate()) {
                    studentModel studenModel = studentModel(
                        Name: Name.text,
                        Email: Email.text,
                        Address: Address.text);
                    AddStudent(studenModel);
                    Name.clear();
                    Email.clear();
                    Address.clear();
                  }
                }
              },
              child: Text(isEdited_mode ? "Update" : "Save"))
        ],
      )),
    );
  }
}
